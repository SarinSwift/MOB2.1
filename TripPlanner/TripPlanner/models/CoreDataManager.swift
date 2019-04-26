//
//  CoreDataManager.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/26/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        return context
    }()
    
    class func addTrip(sender: Notification) {
        let entity = NSEntityDescription.entity(forEntityName: "Trips", in: context)!
        let trip = NSManagedObject(entity: entity, insertInto: context)
        trip.setValue(sender.object, forKeyPath: "name")
        
        saveTrip()
    }
    
    class func saveTrip() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    class func deleteTrip(trip: NSManagedObject) {
        context.delete(trip)
        saveTrip()
    }
    
    class func retrieveTrips() -> [Trips] {
        do {
            let fetchRequest = NSFetchRequest<Trips>(entityName: "Trips")
            let results = try context.fetch(fetchRequest)
            
            return results 
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            
            return []
        }
    }
}
