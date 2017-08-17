//
//  Business.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-17.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Business: Model {
    
    struct Coordinates {
        let latitude: Double
        let longitude: Double
    }
    
    struct Location {
        let city: String?
        let country: String?
        let address2: String?
        let address3: String?
        let state: String?
        let address1: String?
        let zipCode: String?
    }
    
    let rating: Float?
    let name: String?
    let coordinates: Coordinates?
    let imageUrl: String?
    let location: Location?
    
    init(rating: Float?, name: String?, coordinates: Coordinates?, imageUrl: String?, location: Location?) {
        self.rating = rating
        self.name = name
        self.coordinates = coordinates
        self.imageUrl = imageUrl
        self.location = location
    }
    
    static func fromJSON(_ json: JSON) -> Business? {
        guard case .dictionary = json.type else {
            return nil
        }
        
        var coordinates: Coordinates?
        var location: Location?
        
        if let lat = json["coordinates"]["latitude"].double,
            let long = json["coordinates"]["longitude"].double {
            coordinates = Coordinates(latitude: lat, longitude: long)
        }
        
        if let locationDic = json["location"].dictionary {
            location = Location(city: locationDic["city"]?.string,
                                country: locationDic["country"]?.string,
                                address2: locationDic["address2"]?.string,
                                address3: locationDic["address3"]?.string,
                                state: locationDic["state"]?.string,
                                address1: locationDic["address1"]?.string,
                                zipCode: locationDic["zip_code"]?.string)
        }
        
        let rating = json["rating"].float
        let name = json["name"].string
        let imageUrl = json["image_url"].string
 
        
        return Business(rating: rating, name: name, coordinates: coordinates, imageUrl: imageUrl, location: location)
    }
}
