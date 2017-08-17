//
//  Model.swift
//  Foodie
//
//  Created by Justin Li on 2017-08-16.
//  Copyright © 2017 Justin Li. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Model {
    static func fromJSON(_ json: JSON) -> Self?
}
