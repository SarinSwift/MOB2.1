//
//  ViewController.swift
//  TripPlanner
//
//  Created by Sarin Swift on 4/25/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tripNames = ["Trip to Phuket"] {
        didSet {
            tableView.reloadData()      // Update the table view everytime we update the trip names
        }
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addTripName(_:)), name: .didAddTripName, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didAddTripName, object: String.self)
    }
    
    @objc func addTripName(_ sender: Notification){
        self.tripNames.append(sender.object as! String)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripNameCellId", for: indexPath) as! TripsTableViewCell
        cell.tripNameLabel.text = tripNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
