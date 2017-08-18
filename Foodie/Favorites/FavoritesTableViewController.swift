//
//  FavoritesTableViewController.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-16.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class FavoritesTableViewController: UITableViewController {
    
    var sortBtn: UIButton!
    var businesses = [ManagedFavoriteBusiness]()
    var favoritesFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    func configureView() {
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
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
        self.fetchAllFavorites(sortAscending: self.sortBtn.isSelected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didClickSearchItem() {
        let searchView = StoryboardProvider.viewController(from: "Search", classType: SearchViewController.self)
        self.showDetailViewController(searchView, sender: self)
    }
    
    func didClickSortBtn() {
        self.sortBtn.isSelected = !self.sortBtn.isSelected
        self.fetchAllFavorites(sortAscending: self.sortBtn.isSelected)
    }

    func updateTableViewBackground() {
        if let count = self.favoritesFetchedResultsController?.fetchedObjects?.count,
            count > 0 {
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = .singleLine
        } else {
            self.tableView.separatorStyle = .none
            self.tableView.backgroundView = EmptyTablePlaceholderView.placeHolderView(with: "There are currently no favorites. Please search for a business and then add it to the favorite list.")
        }
    }
}


