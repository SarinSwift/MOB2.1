//
//  TripDetailedViewController.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/26/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit
import CoreData

class TripDetailedViewController: UIViewController {
    
    var mainTrip: Trips?
    var allWaypointsInThisTrip: [NSMutableOrderedSet]?

    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
        self.tripNameLabel.text = mainTrip?.value(forKey: "name") as? String
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("view will appear: \(mainTrip?.waypoint)")
        
        // fetch from coredata
        let waypointsArr = mainTrip?.waypoint as? [NSMutableOrderedSet]
        allWaypointsInThisTrip = waypointsArr
    }
    
    func setNavBar() {
        self.navigationController?.title = "Add Waypoint"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackFromBack))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addWayPoint))
    }
    
    @objc func goBackFromBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addWayPoint() {
        navigateToAddWaypointVC()
    }
    
    @IBAction func addMoreBtnTapped(_ sender: Any) {
        navigateToAddWaypointVC()
    }
    
    func navigateToAddWaypointVC() {
        // segue to way point
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addWayPointVC = storyboard.instantiateViewController(withIdentifier: "addWayPointID") as! AddWayPointViewController
        addWayPointVC.mainTrip = self.mainTrip
        addWayPointVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        // setting the main trip we just selected here so we can save way points in this specific trip
        
        self.navigationController?.pushViewController(addWayPointVC, animated: true)
    }
}

extension TripDetailedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTrip?.waypoint?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleWaypoint = mainTrip?.waypoint?[indexPath.row] as? WayPoints
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripDetailCellId", for: indexPath)
        cell.textLabel?.text = String(format:"%f", singleWaypoint!.long)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let displayWaypointVC = storyboard.instantiateViewController(withIdentifier: "displayWaypointId") as! DisplayWaypointViewController
        displayWaypointVC.title = mainTrip?.value(forKey: "name") as? String
        // TODO: display the saved way point
        self.navigationController?.pushViewController(displayWaypointVC, animated: true)

    }
}
