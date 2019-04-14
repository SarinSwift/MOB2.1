//
//  Movie.swift
//  LearningNSCoding
//
//  Created by Sarin Swift on 4/13/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation

class Movie: NSObject, NSCoding {
    var title: String
    var duration: Int
    
    // Memberwise initializer
    init(title: String, duration: Int) {
        self.title = title
        self.duration = duration
    }
    
    // MARK: NSCoding 
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "title") as? String else {
            return nil
        }
        let duration = aDecoder.decodeCInt(forKey: "duration")
        
        self.init(title: title, duration: Int(duration))
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.duration, forKey: "duration")
    }
}
