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
    @IBOutlet weak var collectionView: UICollectionView!
    var sortBtn: UIButton!
    
    var businesses = [Business]()
    
    func configureView() {
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        
        self.sortBtn = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 25, height: 25)))
        self.sortBtn.setImage(UIImage(named: "sort_ascending")?.withRenderingMode(.alwaysTemplate), for: .selected)
        self.sortBtn.setImage(UIImage(named: "sort_descending")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.sortBtn.addTarget(self, action: #selector(didClickSortBtn), for: .touchUpInside)
        self.sortBtn.isSelected = true
        
        if case (UIUserInterfaceSizeClass.compact, _) = self.sizeClass() {
            self.searchBar.barTintColor = UIColor.appTintColor()
            self.locationSearchBar.barTintColor = UIColor.appTintColor()
            self.searchBar.backgroundImage = UIImage()
            self.locationSearchBar.backgroundImage = UIImage()
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: self.sortBtn)]
            self.searchBarsContainer.backgroundColor = UIColor.appTintColor()
            navigationItem.leftItemsSupplementBackButton = true
        } else {
            self.searchBar = UISearchBar()
            self.locationSearchBar = UISearchBar()
            self.navigationItem.titleView = self.searchBar
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: self.sortBtn), UIBarButtonItem(customView: self.locationSearchBar)]
            navigationItem.leftItemsSupplementBackButton = false
        }
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        if #available(iOS 10.0, *) {
            self.collectionView.prefetchDataSource = self
        }
        
        self.searchBar.placeholder = "Search"
        self.locationSearchBar.placeholder = "Location"
        self.searchBar.delegate = self
        self.locationSearchBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        if case (UIUserInterfaceSizeClass.regular, _) = self.sizeClass() {
            let secondSearchBarFrame = self.locationSearchBar.frame
            self.locationSearchBar.frame = CGRect(x: secondSearchBarFrame.origin.x, y: secondSearchBarFrame.origin.y, width: self.view.frame.width/3.0, height: secondSearchBarFrame.size.height)
        }
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
        self.sortBtn.isSelected = !self.sortBtn.isSelected
        self.businesses = self.businesses.sorted(by: { (b1, b2) -> Bool in
            let result = b1.name ?? "" < b2.name ?? ""
            return self.sortBtn.isSelected ? result : !result
        })
        self.collectionView.reloadData()
    }
    
    func showProgress(_ show: Bool) {
        
    }
}

