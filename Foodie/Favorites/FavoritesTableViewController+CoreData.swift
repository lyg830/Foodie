//
//  FavoritesTableViewController+CoreData.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-18.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import Foundation
import CoreData

extension FavoritesTableViewController: NSFetchedResultsControllerDelegate {
    
    func fetchAllFavorites(sortAscending: Bool) {
        self.favoritesFetchedResultsController = DatabaseManager.shared.allFavoritesFetchedResultsController(sortAscending: sortAscending)
        self.favoritesFetchedResultsController?.delegate = self
        do {
            try self.favoritesFetchedResultsController?.performFetch()
            self.tableView.reloadData()
            self.updateTableViewBackground()
        } catch {
            self.showAlertController("Error", message: "Problem fetching the favorites list.")
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                self.tableView.insertRows(at: [indexPath], with: .fade)
                self.updateTableViewBackground()
            }
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.updateTableViewBackground()
            }
        case .update:
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
}
