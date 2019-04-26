//
//  AddWayPointViewController.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/26/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class AddWayPointViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
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
}
