//
//  Book.swift
//  RealmPracticeSwift
//
//  Created by Sarin Swift on 5/6/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation
import RealmSwift

class Book: Object {
    @objc dynamic var title = ""
    @objc dynamic var author = ""
    @objc dynamic var year = 0
}
