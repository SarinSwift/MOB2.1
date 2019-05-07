//
//  ViewController.swift
//  RealmPracticeSwift
//
//  Created by Sarin Swift on 5/6/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let store = BookStore()
        let realm = try! Realm()
        store.realm = realm
        
        //TODO: Create a book
        //A Game of Thrones (A Song of Ice and Fire #1)
        //George R. R. Martin"
        //1997
        
        //TODO: Save the book
        
        
        //TODO: Find the book by title, print the result.
        
    }
    
    
}

