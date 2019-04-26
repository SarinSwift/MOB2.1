//
//  SingleTripDetailViewController.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/26/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getStartedBtnTapped(_ sender: UIButton) {
        // seque to way point
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addWayPointVC = storyboard.instantiateViewController(withIdentifier: "addWayPointID") as! AddWayPointViewController
        addWayPointVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(addWayPointVC, animated: true)
    }
}
