//
//  ViewController.swift
//  plants
//
//  Created by Adriana González Martínez on 4/21/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var managedContext = NSManagedObjectContext()
    var mainPlant : Plant?

    @IBOutlet weak var tableView: UITableView!
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var dates: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Water log"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        
        let plantSpecies = "Cactus"
        let plantSearch: NSFetchRequest<Plant> = Plant.fetchRequest()
        plantSearch.predicate = NSPredicate(format: "%K == %@", #keyPath(Plant.species), plantSpecies)

        do {
            let results = try managedContext.fetch(plantSearch)
            if results.count > 0 {
                mainPlant = results.first
            } else {
                // not found, create cactus
                mainPlant = Plant(context: managedContext)
                mainPlant?.species = plantSpecies
                try managedContext.save()
            }
        } catch let error as NSError {
            print("Error: \(error) description: \(error.userInfo)")
        }
    }
    

    @IBAction func addLog(_ sender: Any) {
//        dates.append(Date())
        
        
        //new water date entity
        let waterDate = WaterDate(context: managedContext)
        waterDate.date = NSDate()
        
        //add it to the Plant's dates set
        if let plant = mainPlant, let dates = plant.waterDates?.mutableCopy() as? NSMutableOrderedSet {
            dates.add(waterDate)
            plant.waterDates = dates
        }
        
        //save the managed object context
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
        }
        
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainPlant?.waterDates?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let waterDate = mainPlant?.waterDates?[indexPath.row] as? WaterDate
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dateFormatter.string(from: waterDate?.date as! Date)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let waterDate = mainPlant?.waterDates?[indexPath.row] as? WaterDate
        
        if editingStyle == .delete {
            managedContext.delete(waterDate!)
            
            do {
                try managedContext.save()
                tableView.reloadData()
            } catch let error as NSError {
                print("Error while deleting person: \(error.userInfo)")
            }
        }
    }
    
}

