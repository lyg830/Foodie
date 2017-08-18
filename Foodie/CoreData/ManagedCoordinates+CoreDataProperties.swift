//
//  ManagedCoordinates+CoreDataProperties.swift
//  
//
//  Created by Justin Li on 2017-08-18.
//
//

import Foundation
import CoreData


extension ManagedCoordinates {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedCoordinates> {
        return NSFetchRequest<ManagedCoordinates>(entityName: "ManagedCoordinates");
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var business: ManagedFavoriteBusiness?

}
