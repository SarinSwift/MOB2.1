//
//  TripDetailedViewController.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/26/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class TripDetailedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavBar()
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
        // TODO:
        // navigate to adding a waypoint
        print("adding a waypoint")
        
        // seque to way point
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addWayPointVC = storyboard.instantiateViewController(withIdentifier: "addWayPointID") as! AddWayPointViewController
        addWayPointVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(addWayPointVC, animated: true)
    }
}
