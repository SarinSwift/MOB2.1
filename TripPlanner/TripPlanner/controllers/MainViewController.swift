//
//  ViewController.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/25/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    var tripNames = [NSManagedObject]() {
        didSet {
            tableView.reloadData()      // Update the table view everytime we update the trip names
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tripNames = CoreDataManager.retrieveTrips()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addTripName(_:)), name: .didAddTripName, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didAddTripName, object: String.self)
    }
    
    @objc func addTripName(_ sender: Notification){
        CoreDataManager.addTrip(sender: sender)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tripName = tripNames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripNameCellId", for: indexPath) as! TripsTableViewCell
        cell.tripNameLabel.text = tripName.value(forKey: "name") as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let tripToDelete = tripNames[indexPath.row]
            CoreDataManager.deleteTrip(trip: tripToDelete as! Trips)
            tripNames = CoreDataManager.retrieveTrips()
        }
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // If this trip has way points then go to tripDetailScreen
        let theTrip = tripNames[indexPath.row] as? Trips
        if theTrip?.waypoint?.count != 0 {
            print("has waypoints")
            let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
            let tripDetail = storyboard1.instantiateViewController(withIdentifier: "tripDetailedID") as! TripDetailedViewController
            tripDetail.mainTrip = tripNames[indexPath.row] as? Trips
            self.navigationController?.pushViewController(tripDetail, animated: true)
            
        } else {
            print("doesn't have waypoints")
            // No way points, Show a page to add waypoints
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let singleTripDetailToAdd = storyboard.instantiateViewController(withIdentifier: "singleDetailedID") as! GetStartedViewController
            singleTripDetailToAdd.title = theTrip?.name
            singleTripDetailToAdd.mainTrip = tripNames[indexPath.row] as? Trips
            self.navigationController?.pushViewController(singleTripDetailToAdd, animated: true)
        }
        
    }
}
