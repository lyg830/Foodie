//
//  SplitViewController.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-15.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        if case (UIUserInterfaceSizeClass.regular, _) = self.sizeClass() {
            let searchView = StoryboardProvider.viewController(from: "Search", classType: SearchViewController.self)
            self.showDetailViewController(UINavigationController(rootViewController: searchView), sender: self)
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

extension SplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        
        if let topAsSearchViewController = secondaryAsNavController.topViewController as? SearchViewController,
            topAsSearchViewController.businesses.count == 0 {
            return true
        } else if let topAsDetailViewController = secondaryAsNavController.topViewController as? BusinessDetailViewController,
            topAsDetailViewController.business == nil {
            return true
        }
        
        return false
    }
}
