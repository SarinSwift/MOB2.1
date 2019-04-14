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
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var currMessageTextView: UITextView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the current message to be whatever is saved in keychain
        currMessageTextView.text = keychain.get("message")
        switchBtn.isOn = UserDefaults.standard.bool(forKey: "isSynchMode")
//        keychain.synchronizable = switchBtn.isOn
//        print("The keychain in synchrinizable: \(keychain.synchronizable)")
    }

    @IBAction func saveBtnTapped(_ sender: UIButton) {
        // save in keychain
        keychain.set(saveMessageTextField.text ?? "", forKey: "message")
        currMessageTextView.text = keychain.get("message")
        
        if switchBtn.isOn {
            keychain.synchronizable = true
        } else {
            keychain.synchronizable = false
        }
    }
    @IBAction func deleteBtnTapped(_ sender: UIButton) {
        // remove from kaychain
        keychain.delete("message")
        currMessageTextView.text = ""
    }
    
    @IBAction func switchBtnTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(switchBtn.isOn, forKey: "isSynchMode")
        if switchBtn.isOn {
            // TURN ON sync mode
            print("turning on")
            keychain.synchronizable = true
            keychain.set(saveMessageTextField.text ?? "", forKey: "message")
            
        } else {
            // TURN OFF sync mode
            print("turning off")
            keychain.synchronizable = false
        }
    }
}

