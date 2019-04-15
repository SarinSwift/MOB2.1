//
//  ViewController.swift
//  LearningNSCoding
//
//  Created by Sarin Swift on 4/12/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var savedMovieArr = [Movie]()

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNewMoviesArr()
    }
    
    func loadNewMoviesArr() {
        // Retrieving a value from a key
        do {
            if let data = UserDefaults.standard.data(forKey: "savedMovieArr"),
                let myMovieList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Movie] {
                savedMovieArr = myMovieList
                print("successfully loaded saved movies")
            }
        } catch {
            print("error unarchiving data: \(error.localizedDescription)")
        }
    }

    @IBAction func saveBtnTapped(_ sender: UIButton) {
        guard let titlesText = titleTextField.text, let durationsText = durationTextField.text else {
            return
        }
        guard let durationsTextInt = Int(durationsText) else {
            return
        }
        
        // Updating the tableview with the new input values
        let newMovie = Movie(title: titlesText, duration: durationsTextInt)
        savedMovieArr.append(newMovie)
        tableView.reloadData()
        
        // Setting a value for a key
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: savedMovieArr, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: "savedMovieArr")
            UserDefaults.standard.synchronize()
            print("Saved to UserDefaults")
        } catch {
            print("error archiving data: \(error.localizedDescription)")
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedMovieArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCellId", for: indexPath) as! MovieCell
        cell.titleLabel.text = savedMovieArr[indexPath.row].title
        cell.durationLabel.text = String(savedMovieArr[indexPath.row].duration)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
