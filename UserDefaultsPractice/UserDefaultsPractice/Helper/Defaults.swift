//
//  Defaults.swift
//  UserDefaultsPractice
//
//  Created by Sarin Swift on 4/8/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation

// Manage saving a user's token with UserDefaults
// We have the UserDefault request in one place so we can reuse that piece of code
struct Defaults {
    // static: tied to the struct itself and yiu can acces it directly on the struct
    // not using static: will have to instantiate Defaults() before getting to call the variables or methods
    
    static let token = "token"
    static let tokenKey = "tokenKey"
    static let userDefaults = UserDefaults.standard
    
    struct Model {
        var token: String?
        
        init(token: String) {
            self.token = token
        }
    }
    
    static var saveToken = { (token: String) in
        let userDefaults = UserDefaults.standard
        userDefaults.set(token, forKey: tokenKey)
    }
    
    static var getToken = { () -> Model in
        let returnedToken = userDefaults.string(forKey: tokenKey)
        return Model(token: returnedToken ?? "no value saved in UserDefaults")
    }
    
    static func clearUserData() {
        userDefaults.removeObject(forKey: tokenKey)
    }
}

