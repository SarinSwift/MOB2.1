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

class AddWayPointViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Properties
    
    var placesClient: GMSPlacesClient!
    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    
    
    // MARK: - Set up
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        setSearchBar()
        setLocation()
        mapView.delegate = self
        
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        placesClient = GMSPlacesClient.shared()
    }
    
    func setNavBar() {
        self.navigationController?.title = "Add Waypoint"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackFromBack))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(goBackFromSave))
    }
    func setSearchBar() {
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self as GMSAutocompleteResultsViewControllerDelegate
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = searchController?.searchBar
        definesPresentationContext = true
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.modalPresentationStyle = .popover
    }
    func setLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
    // MARK: - Methods
    
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
}

extension AddWayPointViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        
        // TODO: Add the pin to the map
        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place coordinates: \(place.coordinate)")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        print("Error: \(error.localizedDescription)")
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
