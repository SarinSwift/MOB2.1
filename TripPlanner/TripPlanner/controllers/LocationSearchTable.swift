//
//  LocationSearchTable.swift
//  TripPlanner
//
//  Created by Sarin Swift on 5/4/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class LocationSearchTable: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
}
