//
//  BusinessDetailViewController+TableView.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-18.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit
import Kingfisher

extension BusinessDetailViewController: UITableViewDataSource {
    
    var navAndStatusHeight: CGFloat {
        get {
            return 64.0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.reviews.count > 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessDetailInfoCell", for: indexPath) as! BusinessDetailInfoTableViewCell
            cell.textLabel?.text = self.business?.name
            
            if let location = self.business?.location {
                let addrArr:[String] = [location.address1, location.city, location.state, location.zipCode, location.country].flatMap{$0}
                let addr = addrArr.joined(separator: ", ")
                cell.detailTextLabel?.text = addr
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "businessDetailReviewCell", for: indexPath) as! BusinessDetailReviewTableViewCell
            
            if self.reviews.count > indexPath.row {
                let review = self.reviews[indexPath.row]
                cell.nameLabel.text = review.user?.name
                cell.timeLabel.text = review.timeCreated
                cell.reviewLabel.text = review.text
                
                cell.imgView?.kf.setImage(with: URL(string: review.user?.imageUrl ?? ""), options: [KingfisherOptionsInfoItem.cacheMemoryOnly, KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.2))])
            }
            
            return cell
        }
    }
}

extension BusinessDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        } else {
            return 34
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: self.tableView(tableView, heightForHeaderInSection: 1)))
            view.backgroundColor = UIColor.groupTableViewBackground
            let label = UILabel()
            view.addSubview(label)
            label.text = "Reviews"
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
                                         label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
                                         label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)])
            return view
        } else {
            return nil
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
        if scrollView.contentOffset.y <= -self.topImgViewHeight {
            let offset = -(scrollView.contentOffset.y + self.topImgViewHeight)
            let scale = (offset/self.topImgViewHeight) + 1
            let translation = CGAffineTransform(translationX: 0, y: offset/2)
            self.imgView.transform = translation.scaledBy(x: scale, y: scale)
            
        } else {
            var offset = -scrollView.contentOffset.y
            if offset <= navAndStatusHeight {
                offset = navAndStatusHeight
            }
            
            self.imgView.transform = CGAffineTransform(translationX: 0, y: -(self.imgView.frame.height-offset))
        }
    }
}

extension BusinessDetailViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.flatMap({ (indexPath) -> URL? in
            guard self.reviews.count > indexPath.row, indexPath.section == 1 else {
                return nil
            }
            return URL(string: self.reviews[indexPath.row].user?.imageUrl ?? "")
        })
        
        let prefetcher = ImagePrefetcher(urls: urls, options: [KingfisherOptionsInfoItem.cacheMemoryOnly])
        prefetcher.start()
    }
}
