//
//  LocationSearchTable.swift
//  TripPlanner
//
//  Created by Sarin Swift on 5/4/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class LocationSearchTable: UITableViewController {
    
    var resultsArrTable = [[String: AnyObject]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // data that was sent from AddWayPointViewController
        return resultsArrTable.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        // grab the data out of the array of dict
        let place = self.resultsArrTable[indexPath.row]
        cell?.textLabel?.text = "\(String(describing: place["name"])) \(String(describing: place["formatted_address"]))"
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
