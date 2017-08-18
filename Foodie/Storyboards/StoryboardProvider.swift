//
//  StoryboardProvider.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-18.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

class StoryboardProvider {
    static func viewController<T: UIViewController>(from storyboard: String, classType: T.Type) -> UIViewController {
        return viewController(from: storyboard, identifier: String(describing: classType))
    }
    
    static func viewController(from storyboard: String, identifier: String) -> UIViewController {
        return UIStoryboard.init(name: storyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
    }
}
