//
//  DisplayWaypointViewController.swift
//  TripPlanner
//
//  Created by Sarin Swift on 5/8/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit
import MapKit

class DisplayWaypointViewController: UIViewController {
    
    var lat: Double?
    var lng: Double?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the pin on map
        let annotation = MKPointAnnotation()
        if let lat = lat, let lng = lng {
            annotation.coordinate.latitude = lat
            annotation.coordinate.longitude = lng
        }
        
        mapView.addAnnotation(annotation)
    }
    
}
