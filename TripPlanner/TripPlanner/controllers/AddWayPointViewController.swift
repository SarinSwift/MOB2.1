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
import CoreData

class AddWayPointViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Properties
    
    var mainTrip: Trips?
    var placesClient: GMSPlacesClient!
    
    var placeName: String = ""
    var placeLat: Double = 0
    var placeLong: Double = 0
    
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
        print("check if mapview's annotation array is nil: \(mapView.annotations.count)")
        
        if mapView.annotations.count == 0 {
            print("Could not determine location on map. No annotations saved")
        } else {
            print("saving this coordinate: \(mapView.annotations[0].coordinate)")
            // new waypoint entity
            let waypoint = WayPoints(context: CoreDataManager.context)
            waypoint.name = placeName
            waypoint.lat = placeLat
            waypoint.long = placeLong
            
            // add to trip waypoints set
            mainTrip?.addToWaypoint(waypoint)
            CoreDataManager.saveTrip()
        }
        
        // should not return back to 'getStartedVC' if they had added a real waypoint!
        if let controllersOnNavStack = self.navigationController?.viewControllers {
            let n = controllersOnNavStack.count
            if controllersOnNavStack[n-2].restorationIdentifier != "singleDetailedID" || mapView.annotations.count == 0 {
                self.navigationController?.popViewController(animated: true)
            } else {
                // pop 2 times
                print("is trueee and pop 2 times")
                let popTo = self.navigationController?.viewControllers[n-3]
                self.navigationController?.popToViewController(popTo!, animated: true)
            }
        }
    }
    
}

extension AddWayPointViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place coordinates: \(place.coordinate)")
        
        placeName = place.name!
        placeLat = place.coordinate.latitude
        placeLong = place.coordinate.longitude
        
        // remove all annotations so there's only 1 current one on the map at all times
        mapView.removeAnnotations(mapView.annotations)
        
        // add the annotation
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: place.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        // adding the placemark of the user's location
        let annotation = MKPointAnnotation()
        annotation.coordinate = place.coordinate
        annotation.title = place.name
        annotation.subtitle = place.formattedAddress
        mapView.addAnnotation(annotation)
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
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}
