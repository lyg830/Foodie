//
//  BusinessSearchCollectionViewCell.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-17.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

class BusinessSearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addrLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        containerView.layer.shouldRasterize = true
        containerView.layer.rasterizationScale = UIScreen.main.nativeScale
    }
    
}
