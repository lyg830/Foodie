//
//  Review.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-18.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Review: Model {
    
    struct ReviewUser {
        let name: String?
        let imageUrl: String?
    }
    
    let rating: Float?
    let text: String?
    let timeCreated: String?
    let user: ReviewUser?
    
    init(rating: Float?, text: String?, timeCreated: String?, user: ReviewUser?) {
        self.rating = rating
        self.text = text
        self.timeCreated = timeCreated
        self.user = user
    }
    
    static func fromJSON(_ json: JSON) -> Review? {
        guard case .dictionary = json.type else {
            return nil
        }
        
        var user: ReviewUser?
        
        if let name = json["user"]["name"].string {
            user = ReviewUser(name: name, imageUrl: json["user"]["image_url"].string)
        }
        
        let rating = json["rating"].float
        let text = json["text"].string
        let timeCreated = json["time_created"].string
        
        return Review(rating: rating, text: text, timeCreated: timeCreated, user: user)
    }
}
