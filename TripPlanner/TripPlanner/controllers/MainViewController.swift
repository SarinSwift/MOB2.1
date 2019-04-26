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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addTripName(_:)), name: .didAddTripName, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Trips")
        do {
            tripNames = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didAddTripName, object: String.self)
    }
    
    @objc func addTripName(_ sender: Notification){
        // Adding our trip to core data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Trips", in: managedContext)!
        let trip = NSManagedObject(entity: entity, insertInto: managedContext)
        trip.setValue(sender.object, forKeyPath: "name")
        
        do {
            try managedContext.save()
            tripNames.append(trip)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let tripToDelete = tripNames[indexPath.row]
        
        if editingStyle == .delete {
            managedContext.delete(tripToDelete)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error while deleting person: \(error.userInfo)")
            }
        }
        
        // fetch new data / reload table
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trips")
        
        do {
            tripNames = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Error while fetching data from coredata: \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO:
        
        // If this trip has way points then go to tripDetailScreen
        let storyboard1 = UIStoryboard(name: "Main", bundle: nil)
        let tripDetail = storyboard1.instantiateViewController(withIdentifier: "tripDetailedID") as! TripDetailedViewController
        self.navigationController?.pushViewController(tripDetail, animated: true)

        
        // If No way points, Show a page to add waypoints
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let singleTripDetailToAdd = storyboard.instantiateViewController(withIdentifier: "singleDetailedID") as! GetStartedViewController
//        self.navigationController?.pushViewController(singleTripDetailToAdd, animated: true)
    }
}
