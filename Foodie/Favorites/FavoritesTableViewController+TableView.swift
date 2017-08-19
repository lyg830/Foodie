//
//  FavoritesTableViewController+TableView.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-18.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit
import Kingfisher

extension FavoritesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = self.favoritesFetchedResultsController?.sections {
            return sections.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.favoritesFetchedResultsController?.sections,
        sections.count > section else {
                return 0
        }
        
        return sections[section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! FavoritesTableViewCell
        let record = self.favoritesFetchedResultsController?.object(at: indexPath)
        
        if let name = record?.name {
            cell.nameLabel.text = name
        }
        
        if let location = record?.location {
            let addrArr:[String] = [location.city, location.state, location.country].flatMap{$0}
            let addr = addrArr.joined(separator: ", ")
            cell.addrLabel.text = addr
        }
        
        cell.imgView.kf.setImage(with: URL(string: record?.imageUrl ?? ""), options: [KingfisherOptionsInfoItem.transition(ImageTransition.fade(0.2))])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete,
            let record = self.favoritesFetchedResultsController?.object(at: indexPath) {
            DatabaseManager.shared.deleteObejct(object: record)
            DatabaseManager.shared.saveContext()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let record = self.favoritesFetchedResultsController?.object(at: indexPath),
        let businessDetailView = StoryboardProvider.viewController(from: "BusinessDetail", classType: BusinessDetailViewController.self) as? BusinessDetailViewController else {
            return
        }
        
        var coordinates: Business.Coordinates?
        if let managedCoordinates = record.coordinates {
            coordinates = Business.Coordinates(latitude: managedCoordinates.latitude, longitude: managedCoordinates.longitude)
        }
        
        var location: Business.Location?
        if let managedLocation = record.location {
            location = Business.Location(city: managedLocation.city, country: managedLocation.country, address2: managedLocation.address2, address3: managedLocation.address3, state: managedLocation.state, address1: managedLocation.address1, zipCode: managedLocation.zipCode)
        }
        
        let business = Business(rating: record.rating as Float?, name: record.name, coordinates: coordinates, imageUrl: record.imageUrl, location: location, id: record.id)
        businessDetailView.business = business
        
        if self.splitViewController?.isCollapsed ?? true {
            self.showDetailViewController(businessDetailView, sender: self)
        } else {
            let detailNVC = UINavigationController()
            let searchView = StoryboardProvider.viewController(from: "Search", classType: SearchViewController.self)
            detailNVC.viewControllers = [searchView, businessDetailView]
            self.showDetailViewController(detailNVC, sender: self)
        }
    }
}
