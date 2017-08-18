//
//  ManagedLocation+CoreDataProperties.swift
//  
//
//  Created by Justin Li on 2017-08-18.
//
//

import Foundation
import CoreData


extension ManagedLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedLocation> {
        return NSFetchRequest<ManagedLocation>(entityName: "ManagedLocation");
    }

    @NSManaged public var address1: String?
    @NSManaged public var address2: String?
    @NSManaged public var address3: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var state: String?
    @NSManaged public var zipCode: String?
    @NSManaged public var business: ManagedFavoriteBusiness?

}
