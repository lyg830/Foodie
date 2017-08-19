//
//  FavoritesTableViewCell.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-16.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addrLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgView.layer.cornerRadius = 5
        self.imgView.layer.masksToBounds = true
        self.imgView.layer.shouldRasterize = true
        self.imgView.layer.rasterizationScale = UIScreen.main.nativeScale
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
