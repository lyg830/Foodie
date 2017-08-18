//
//  FavoritesTableViewController.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-16.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavoritesTableViewController: UITableViewController {
    
    var searchViewController: SearchViewController? = nil
    var sortBtn: UIButton!
    var businesses = [Business]()
    
    func configureView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.searchViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? SearchViewController
        }
        
        self.sortBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 25, height: 25)))
        self.sortBtn.setImage(UIImage(named: "sort_ascending")?.withRenderingMode(.alwaysTemplate), for: .selected)
        self.sortBtn.setImage(UIImage(named: "sort_descending")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.sortBtn.addTarget(self, action: #selector(didClickSortBtn), for: .touchUpInside)
        self.sortBtn.isSelected = true
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didClickSearchItem))
            self.navigationItem.rightBarButtonItem = searchItem
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.sortBtn)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didClickSearchItem() {
        guard let searchView = self.searchViewController else {
            return
        }
        
        self.showDetailViewController(searchView, sender: self)
    }
    
    func didClickSortBtn() {
        self.sortBtn.isSelected = !self.sortBtn.isSelected
        self.businesses = self.businesses.sorted(by: { (b1, b2) -> Bool in
            let result = b1.name ?? "" < b2.name ?? ""
            return self.sortBtn.isSelected ? result : !result
        })
        self.tableView.reloadData()
    }
}

extension FavoritesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

extension FavoritesTableViewController {
    
    
}
