//
//  Trips+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Sarin Swift on 5/9/19.
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
    @NSManaged public var waypoint: NSMutableOrderedSet?

}

// MARK: Generated accessors for waypoint
extension Trips {

    @objc(addWaypointObject:)
    @NSManaged public func addToWaypoint(_ value: WayPoints)

    @objc(removeWaypointObject:)
    @NSManaged public func removeFromWaypoint(_ value: WayPoints)

    @objc(addWaypoint:)
    @NSManaged public func addToWaypoint(_ values: NSSet)

    @objc(removeWaypoint:)
    @NSManaged public func removeFromWaypoint(_ values: NSSet)

}
