//
//  ViewController.swift
//  UserDefaultsPractice
//
//  Created by Sarin Swift on 4/8/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Defaults.saveToken("Sarin is working hard"))
        print(Defaults.getToken())
        print(Defaults.clearUserData())
        print(Defaults.getToken())
    }


}

