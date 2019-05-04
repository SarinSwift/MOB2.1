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
    
    // MARK: - Properties
    
    private let locationManager = CLLocationManager()
    
    var resultSearchController:UISearchController? = nil
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Set up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        setSearchBar()
        setLocation()
        mapView.delegate = self
    }
    
    func setNavBar() {
        self.navigationController?.title = "Add Waypoint"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackFromBack))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(goBackFromSave))
    }
    func setSearchBar() {
        // This will serve as the searchResultsUpdater delegate
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        // configure the search bar and embeds in the nav bar
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        // we want the search bar accessible at all times
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        // semi-transparent background when the search bar is selected
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    func setLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @objc func goBackFromBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func goBackFromSave() {
        // TODO:
        // save contents of way point
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Map view methods
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        let region = MKCoordinateRegion.init(center: (locationManager.location?.coordinate)!, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    
    // MARK: - Search bar delegate
    
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
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        // adding the placemark of the user's location 
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = "Title"
        annotation.subtitle = "subtitle"
        mapView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}
