//
//  AddWayPointViewController.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/26/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces
import GoogleMaps

class AddWayPointViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    // MARK: properties
    
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: set up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        
        mapView.delegate = self
        searchBar.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func setNavBar() {
        self.navigationController?.title = "Add Waypoint"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackFromBack))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(goBackFromSave))
    }
    
    @objc func goBackFromBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goBackFromSave() {
        // TODO:
        // save contents of way point
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: map view methods
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        let region = MKCoordinateRegion.init(center: (locationManager.location?.coordinate)!, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    
    // MARK: Search bar delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Text did change")
        ServiceLayer.request(router: Router.getWaypoint(queryValue: searchText))
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("done")
    }
}

extension AddWayPointViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        locationManager.stopUpdatingLocation()
    }
}
