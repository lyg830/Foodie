//
//  BusinessDetailInfoTableViewCell.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-18.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

class BusinessDetailInfoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        button.setTitle("Favorites", for: .normal)
        button.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        
        self.accessoryView = button
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addToFavorites() {
        
    }

}
