//
//  AppDelegate.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-15.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let navigationBarAppearnce = UINavigationBar.appearance()
        navigationBarAppearnce.isTranslucent = false
        navigationBarAppearnce.barTintColor = UIColor.appTintColor()
        navigationBarAppearnce.tintColor = UIColor.white
        navigationBarAppearnce.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBarAppearnce.setBackgroundImage(UIImage(), for: .default)
        navigationBarAppearnce.shadowImage = UIImage()

        let splitView = SplitViewController()
        let favView = UIStoryboard.init(name: "Favorites", bundle: Bundle.main).instantiateViewController(withIdentifier: "FavoritesTableViewController")
        let searchView = UIStoryboard.init(name: "Search", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchViewController")
        splitView.viewControllers = [UINavigationController(rootViewController: favView), UINavigationController(rootViewController: searchView)]
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        self.window?.rootViewController = splitView
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
}

