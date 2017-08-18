//
//  EmptyTablePlaceholderView.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-18.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

class EmptyTablePlaceholderView: UIView {

    @IBOutlet weak var messageLabel: UILabel!
    
    static func placeHolderView(with message: String) -> EmptyTablePlaceholderView? {
        let view = UINib(nibName: "EmptyTablePlaceholderView", bundle: Bundle.main).instantiate(withOwner: nil, options: nil).first as? EmptyTablePlaceholderView
        view?.messageLabel.text = message
        return view
    }
}
