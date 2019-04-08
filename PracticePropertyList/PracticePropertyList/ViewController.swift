//
//  ViewController.swift
//  PracticePropertyList
//
//  Created by Sarin Swift on 4/3/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var names = [String]()
    var scores = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    func getContent() {
        var format = PropertyListSerialization.PropertyListFormat.xml
        var data: [String: AnyObject] = [:]
        let path: String? = Bundle.main.path(forResource: "new", ofType: "plist")!
        let xmlContents = FileManager.default.contents(atPath: path!)!
        do {
            // we use &format here to explicitly note that we're using the variable format above and not a copy of it!
            data = try PropertyListSerialization.propertyList(from: xmlContents, options: .mutableContainersAndLeaves, format: &format) as! [String : AnyObject]
            
            let dataScores = data["Scores"]! as! [[String: Any]]
            for namesAndScores in dataScores {
                names.append(namesAndScores["Name"] as! String)
                scores.append(namesAndScores["Score"] as! String)
            }
            
        } catch {
            print("Error reading plist: \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getContent()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        cell.textLabel?.text = "\(scores[indexPath.row])   \(names[indexPath.row])"
        return cell
    }
}

