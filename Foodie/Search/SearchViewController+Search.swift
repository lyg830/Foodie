//
//  SearchViewController+Search.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-17.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let term = self.searchBar.text
        var location = self.locationSearchBar.text
        
        if (location ?? "").isEmpty {
            location = "Toronto"
        }
        
        YelpService.shared.searchBusinesses(term: term, location: location!) { (businesses, error) in
            if let error = error, case .statusCode(_) = error {
                print("error: \(error.errorDescription)")
                self.showAlertController("Error", message: (error as? CustomStringConvertible)?.description ?? "Unable to finish the search.")
            }
            
            guard let businesses = businesses else {
                return
            }
            
            self.businesses = businesses.sorted(by: { (b1, b2) -> Bool in
                let result = b1.name ?? "" < b2.name ?? ""
                return self.sortBtn.isSelected ? result : !result
            })
            self.collectionView.reloadData()
            self.updateCollectionViewBackground()
        }
        
        self.searchBar.resignFirstResponder()
        self.locationSearchBar.resignFirstResponder()
    }
}
