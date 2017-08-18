//
//  BusinessDetailInfoTableViewCell.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-18.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import UIKit

protocol BusinessDetailInfoCellDelegate {
    func onAddToFavoritesClick()
}

class BusinessDetailInfoTableViewCell: UITableViewCell {
    
    var delegate: BusinessDetailInfoCellDelegate?
    lazy var favoriteBtn: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        button.setTitle("Favorites", for: .normal)
        button.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addToFavorites() {
        self.delegate?.onAddToFavoritesClick()
    }

}
