//
//  NetworkingManager.swift
//  TripPlanner
//
//  Created by Sarin Swift on 5/3/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class ServiceLayer {
    class func requestPlacesFromGoogle<T: Codable>( router: Router, completion: @escaping (T) -> ())  {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters
        
        // create the url and urlRequest
        guard let url = components.url else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
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
                print("Error, no data")
                return
            }
            
//            let theString: NSString = NSString(data: data, encoding: String.Encoding.ascii.rawValue)!
//            print("data in string format: \(theString)")
            
            
            do {
                
                if let json = try? JSONDecoder().decode(T.self, from: data) {
                    print("decoding the json data")
                    completion(json)
                }
                
            } catch let error as NSError{
                print("error: \(error.userInfo)")
            }
        }
        dataTask.resume()
    }
}
