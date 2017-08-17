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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.searchViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? SearchViewController
        }
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let searchIcon = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didClickSearchIcon))
            self.navigationItem.rightBarButtonItem = searchIcon
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didClickSearchIcon() {
        guard let searchView = self.searchViewController else {
            return
        }
        
        self.showDetailViewController(searchView, sender: self)
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
