//
//  BusinessDetailViewController.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-17.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit
import Kingfisher

class BusinessDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgView: UIImageView!
    
    var business: Business?
    var topImgViewHeight: CGFloat!
    var reviews = [Review]()
    
    func configureView() {
        if let url = self.business?.imageUrl {
            self.imgView.kf.setImage(with: URL(string: url), options: [KingfisherOptionsInfoItem.cacheMemoryOnly, KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.2))])
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        if #available(iOS 10.0, *) {
            self.tableView.prefetchDataSource = self
        }
        
        self.navigationItem.title = self.business?.name
        
    }
    
    override func viewDidLayoutSubviews() {
        topImgViewHeight = self.imgView.frame.height
        self.tableView.contentInset = UIEdgeInsetsMake(topImgViewHeight, 0, 0, 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        guard let id = self.business?.id else {
            // error handling 
            return
        }
        
        YelpService.shared.getReviews(businessId: id) { (reviews, error) in
            if let error = error, case .statusCode(_) = error {
                print("error: \(error.errorDescription)")
                self.showAlertController("Error", message: (error as? CustomStringConvertible)?.description ?? "Unable to get reviews.")
            }
            
            guard let reviews = reviews else {
                return
            }
            
            self.reviews = reviews
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
