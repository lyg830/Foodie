//
//  ManagedFavoriteBusiness+CoreDataProperties.swift
//  
//
//  Created by Justin Li on 2017-08-18.
//
//

import Foundation
import CoreData


extension ManagedFavoriteBusiness {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedFavoriteBusiness> {
        return NSFetchRequest<ManagedFavoriteBusiness>(entityName: "ManagedFavoriteBusiness");
    }

    @NSManaged public var id: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: NSNumber?
    @NSManaged public var coordinates: ManagedCoordinates?
    @NSManaged public var location: ManagedLocation?

}
