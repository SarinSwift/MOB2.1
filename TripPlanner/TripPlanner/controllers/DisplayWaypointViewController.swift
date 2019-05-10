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
    var name: String?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add the zoomed in spot
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.lat!, longitude: self.lng!), span: span)
        mapView.setRegion(region, animated: true)
        
        // set the pin on map
        let annotation = MKPointAnnotation()
        if let lat = lat, let lng = lng {
            annotation.coordinate.latitude = lat
            annotation.coordinate.longitude = lng
            annotation.title = self.name
        }
        
        mapView.addAnnotation(annotation)
    }
    
}
