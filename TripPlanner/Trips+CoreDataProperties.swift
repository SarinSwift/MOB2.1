//
//  Trips+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/26/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//
//

import Foundation
import CoreData


extension Trips {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trips> {
        return NSFetchRequest<Trips>(entityName: "Trips")
    }

    @NSManaged public var name: String?
    @NSManaged public var waypoints: NSMutableOrderedSet?

}

// MARK: Generated accessors for waypoints
extension Trips {

    @objc(addWaypointsObject:)
    @NSManaged public func addToWaypoints(_ value: WayPoints)

    @objc(removeWaypointsObject:)
    @NSManaged public func removeFromWaypoints(_ value: WayPoints)

    @objc(addWaypoints:)
    @NSManaged public func addToWaypoints(_ values: NSSet)

    @objc(removeWaypoints:)
    @NSManaged public func removeFromWaypoints(_ values: NSSet)

}
