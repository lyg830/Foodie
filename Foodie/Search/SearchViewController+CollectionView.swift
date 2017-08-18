//
//  SearchViewController+CollectionView.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-17.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit
import Kingfisher

extension SearchViewController: UICollectionViewDataSource {
    
    var sectionInsets: UIEdgeInsets {
        get {
            if case (UIUserInterfaceSizeClass.compact, _) = self.sizeClass() {
                return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            } else {
                return UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
            }
            
        }
    }
    
    var minimumLineSpacing: CGFloat {
        get {
            if case (UIUserInterfaceSizeClass.compact, _) = self.sizeClass() {
                return 15.0
            } else {
                return 20.0
            }
            
        }
    }
    
    var minimumInteritemSpacing: CGFloat {
        get {
            if case (UIUserInterfaceSizeClass.compact, _) = self.sizeClass() {
                return 15.0
            } else {
                return 20.0
            }
        }
    }
    
    var collectionCellAspectRatio: CGFloat {
        get {
            return 1/1.3
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.businesses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "businessCollectionCell", for: indexPath) as! BusinessSearchCollectionViewCell
        
        if self.businesses.count > indexPath.row {
            let business = self.businesses[indexPath.row]
            cell.nameLabel.text = business.name
            
            if let location = business.location {
                let addrArr:[String] = [location.city, location.state, location.country].flatMap{$0}
                let addr = addrArr.joined(separator: ", ")
                cell.addrLabel.text = addr
            }
            
            cell.imgView.kf.setImage(with: URL(string: business.imageUrl ?? ""), options: [KingfisherOptionsInfoItem.cacheMemoryOnly, KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.2))])
        }
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat
        if case (UIUserInterfaceSizeClass.compact, _) = self.sizeClass() {
            width = (self.collectionView.frame.width - (sectionInsets.left + sectionInsets.right)  - minimumInteritemSpacing)/2.0
        } else {
            width = 200.0
        }
        
        return CGSize(width: width, height: width/self.collectionCellAspectRatio)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let detailVC = UIStoryboard.init(name: "BusinessDetail", bundle: Bundle.main).instantiateViewController(withIdentifier: "BusinessDetailViewController") as? BusinessDetailViewController,
            self.businesses.count > indexPath.row else {
                return
        }

        detailVC.business = self.businesses[indexPath.row]
        self.show(detailVC, sender: self)
    }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.flatMap({ (indexPath) -> URL? in
            guard self.businesses.count > indexPath.row else {
                    return nil
            }
            return URL(string: self.businesses[indexPath.row].imageUrl ?? "")
        })
        
        let prefetcher = ImagePrefetcher(urls: urls, options: [KingfisherOptionsInfoItem.cacheMemoryOnly])
        prefetcher.start()
    }
}
