//
//  ViewController.swift
//  LearningToUseTests
//
//  Created by Sarin Swift on 4/8/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // putting the vowels array in main class so we don't have to create a new array everytime we call vowelsInAString()
    let vowels: [Character] = ["a", "e", "i", "o", "u"]

    @IBOutlet weak var insertNumTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We want to test the title on ViewController
        self.title = "Testing With Swift!"
        
        view.addSubview(insertNumTextField)     // created through storyboards but still had to addsubview
        insertNumTextField.placeholder = "placeholder"
    }

    func vowelsInAString(string: String) -> Int {
        let onlyVowelsStr = string.lowercased().filter{ vowels.contains($0) }
        return onlyVowelsStr.count
    }
    
    func makeTitle(string: String) -> String {
        let arrWords = string.split(separator: " ") // -> ["hello", "world"]
        let capiArrWords = arrWords.map { $0.capitalized } // -> capitalizes only the first letter in each string
        return capiArrWords.joined(separator: " ")
    }
}

