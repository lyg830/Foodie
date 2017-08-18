//
//  UIViewController+SizeClasses.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-17.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func sizeClass() -> (UIUserInterfaceSizeClass, UIUserInterfaceSizeClass) {
        return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
    }
    
    func showAlertController(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
}
