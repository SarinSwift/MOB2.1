//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log   // unified logging system

class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Archiving Paths
    
    // uses this method to look up the url for your apps documents directory. Directory where you save data for the user
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // MARK: Types
    
    struct PropertyKey {
        // 'static' keyword tells that these variables belong to the struct itself and not to instances of the struct
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }

        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        // each of these lines encodes the value of each property and stores them with their corresponding keys
        aCoder.encode(self.name, forKey: PropertyKey.name)
        aCoder.encode(self.photo, forKey: PropertyKey.photo)
        aCoder.encode(self.rating, forKey: PropertyKey.rating)
    }
    
    // required modifier means the initializer must be implemented on every subclass
    // convenience means it's a secondary initializer and it must call a designated init from the same class
    // ? means it might return nil
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage    // because the photo is an optional
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // must call the designated init
        self.init(name: name, photo: photo, rating: rating)
    }
}
