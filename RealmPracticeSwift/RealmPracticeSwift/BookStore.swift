//
//  BookStore.swift
//  RealmPracticeSwift
//
//  Created by Sarin Swift on 5/6/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import Foundation
import RealmSwift

enum RuntimeError: Error {
    case NoRealmSet
}

class BookStore {
    var realm: Realm?
    
    public func saveBook(_ book: Book){
        realm = try! Realm()
        
        try! realm?.write {
            realm?.add(book)
        }
    }
    
    public func findBooksByTitle(_ title: String) -> Results<Book>{
        // create the predicate that matches titles
//        let predicate = NSPredicate(format: "title = %a", title)
        let predicate = NSPredicate(format: "title = %@", title)
        return realm!.objects(Book.self).filter(predicate)
    }
    
    public func createBook(_ title: String, author: String, year: Int ) -> Book{
        let newBook = Book()
        newBook.title = title
        newBook.author = author
        newBook.year = year
        return newBook
    }
    
    public func updateBooks(_ field: String, currentValue: String, updatedValue: String) throws
    {
        let books = try findBooksByField(field, value: currentValue)
        try! realm!.write {
            books.setValue(updatedValue, forKeyPath: "\(field)")
        }
    }
    
    private func findBooksByField(_ field: String, value: String) throws -> Results<Book>
    {
        if (realm != nil) {
            let predicate = NSPredicate(format: "%K = %@", field, value)
            return realm!.objects(Book.self).filter(predicate)
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func deleteBook(_ book: Book) throws {
        realm?.delete(book)
    }
}
