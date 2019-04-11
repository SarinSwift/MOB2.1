//
//  ViewController.swift
//  LearningKeychains
//
//  Created by Sarin Swift on 4/10/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController {
    let keychain = KeychainSwift()

    
    @IBOutlet weak var saveMessageTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var currMessageTextView: UITextView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the current message to be whatever is saved in keychain
        currMessageTextView.text = keychain.get("message")
    }

    @IBAction func saveBtnTapped(_ sender: UIButton) {
        // save in keychain
        keychain.set(saveMessageTextField.text ?? "", forKey: "message")
        currMessageTextView.text = keychain.get("message")
    }
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        // remove from kaychain
        keychain.delete("message")
        currMessageTextView.text = ""
    }
}

