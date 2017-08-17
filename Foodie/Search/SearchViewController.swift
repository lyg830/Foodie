//
//  SearchViewController.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-15.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var locationSearchBar: UISearchBar!
    @IBOutlet weak var searchBarsContainer: UIView!
    
    var businesses = [Business]()
    
    func configureView() {
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        let sortBtn = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(didClickSortBtn))
        
        if case (UIUserInterfaceSizeClass.compact, _) = self.sizeClass() {
            self.searchBar.barTintColor = UIColor.appTintColor()
            self.locationSearchBar.barTintColor = UIColor.appTintColor()
            self.navigationItem.rightBarButtonItems = [sortBtn]
            self.searchBarsContainer.backgroundColor = UIColor.appTintColor()
            navigationItem.leftItemsSupplementBackButton = true
        } else {
            self.searchBar = UISearchBar()
            self.locationSearchBar = UISearchBar()
            self.searchBar.placeholder = "Search"
            self.locationSearchBar.placeholder = "Location"
            self.navigationItem.titleView = self.searchBar
            self.navigationItem.rightBarButtonItems = [sortBtn, UIBarButtonItem(customView: self.locationSearchBar)]
            navigationItem.leftItemsSupplementBackButton = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        let secondSearchBarFrame = self.locationSearchBar.frame
        self.locationSearchBar.frame = CGRect(x: secondSearchBarFrame.origin.x, y: secondSearchBarFrame.origin.y, width: self.view.frame.width/3.0, height: secondSearchBarFrame.size.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didClickSortBtn() {
        
    }

}

