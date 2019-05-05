//
//  Router.swift
//  TripPlanner
//
//  Created by Sarin Swift on 5/3/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation

// https://maps.googleapis.com/maps/api/place/textsearch/json?query=juncelon&key='INSERT_KEY'

enum Router {
    case getWaypoint(queryValue: String)
    
    var apiKey: String {
        return constants.googleApiKey
    }
    
    var scheme: String {
        switch self {
        case .getWaypoint:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getWaypoint:
            return "maps.googleapis.com"
        }
    }
    
    var path: String {
        switch self {
        case .getWaypoint:
            return "/maps/api/place/textsearch/json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getWaypoint(let queryValue):
            return [URLQueryItem(name: "query", value: queryValue),
                    URLQueryItem(name: "key", value: apiKey)]
        }
    }
}
