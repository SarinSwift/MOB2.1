//
//  WayPoints+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/26/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//
//

import Foundation
import CoreData


extension WayPoints {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WayPoints> {
        return NSFetchRequest<WayPoints>(entityName: "WayPoints")
    }

    @NSManaged public var lat: NSNumber?
    @NSManaged public var long: NSNumber?
    @NSManaged public var name: String?
    @NSManaged public var relationship: Trips?

}
