//
//  AddTripViewController.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/25/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {

    @IBOutlet weak var tripNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancelBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        guard tripNameTextField.text != "" else {
            displayAlert(title: "Oh No!", msg: "Add a trip name before you submit")
            return
        }
        
        // Call the notification when we added a new trip name. This will trigger appending into the names array
        NotificationCenter.default.post(name: .didAddTripName, object: tripNameTextField.text!)
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
