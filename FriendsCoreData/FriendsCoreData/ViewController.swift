//
//  ViewController.swift
//  FriendsCoreData
//
//  Created by Sarin Swift on 4/17/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var people = [NSManagedObject]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        fetch()
    }

    @IBAction func addBtnTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Friend", message: "Add the name of your friend", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Add Now", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else { return }
            
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func save(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        // Unlock coredata functionality by creating a managedObjContext
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create a new NSManagedObject and save it in the context by calling this .entity()
        let entity = NSEntityDescription.entity(forEntityName: "Person",
                                                in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // set the name attribute
        person.setValue(name, forKeyPath: "name")
        
        // Save it here and append our new person to the people array
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print(error.userInfo)
        }
    }
    
    func fetch() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        // Creating this NSManagedObjectContext
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // using a fetch request
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        // 
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String  // CoreData uses key-value coding
        return cell
        
    }
}
