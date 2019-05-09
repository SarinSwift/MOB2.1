//
//  WayPoints+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Sarin Swift on 5/9/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//
//

import Foundation
import CoreData


extension WayPoints {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WayPoints> {
        return NSFetchRequest<WayPoints>(entityName: "WayPoints")
    }

    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var name: String?
    @NSManaged public var trip: Trips?

}
