//
//  Place.swift
//  TripPlanner
//
//  Created by Sarin Swift on 5/6/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation

// the data in JSON format has:
// "html_attributions",
// "results": is an array of "geometry",
//                           "name",
//                           "photos", etc.
//      "geometry": has an item "location": which has items "lat", and "lng"

struct Result: Codable {
    let results: [Place]
}

struct Place: Codable {
    let geometry: Geo
    let name: String
}

struct Geo: Codable {
    let location: LatAndLong
}

struct LatAndLong: Codable {
    let lat: Double
    let long: Double
    
    enum CodingKeys: String, CodingKey {
        case lat
        case long = "lng"
    }
}
