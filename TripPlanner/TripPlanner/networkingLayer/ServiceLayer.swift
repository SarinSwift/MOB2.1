//
//  NetworkingManager.swift
//  TripPlanner
//
//  Created by Sarin Swift on 5/3/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class ServiceLayer {
    class func request(router: Router) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        // create the url and urlRequest
        guard let url = components.url else {
            return
        }
        var urlRequest = URLRequest(url: url)
        
        // create the session data task
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            guard response != nil else {
                return
            }
            guard let data = data else {
                return
            }
            
            print(data)
        }
        dataTask.resume()
    }
}
