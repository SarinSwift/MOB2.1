//
//  ViewController.swift
//  LearningToUseTests
//
//  Created by Sarin Swift on 4/8/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var insertNumTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We want to test the title on ViewController
        self.title = "Testing With Swift!"
        
        view.addSubview(insertNumTextField)     // created through storyboards but still had to addsubview
        insertNumTextField.placeholder = "placeholder"
    }

    func vowelsInAString(string: String) -> Int {
        let vowels: [Character] = ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]
        var numberOfVowels = 0
        for char in string {
            if vowels.contains(char) {
                numberOfVowels += 1
            }
        }
        return numberOfVowels
    }
    
    func makeTitle(string: String) -> String {
        let words = string.components(separatedBy: " ")
        var headline = ""
        
        for var word in words {
            let firstChar = word.remove(at: word.startIndex)
            headline += "\(String(firstChar).uppercased())\(word) "
        }
        headline.remove(at: headline.index(before: headline.endIndex))
        return headline
    }
}

