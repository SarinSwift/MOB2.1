//
//  RealmPracticeSwiftTests.swift
//  RealmPracticeSwiftTests
//
//  Created by Sarin Swift on 5/6/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import XCTest
import RealmSwift

@testable import RealmPracticeSwift

class RealmPracticeSwiftTests: XCTestCase {
    
    var bookStore: BookStore!

    override func setUp() {
        // Notice you can configure Realms before creating them. Here we use the in-memory type.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        let realm = try! Realm()
        
        bookStore = BookStore()
        bookStore.realm = realm
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSaveAndGetBook() {
        
        //Given a new book with title: Jungle Book, author: Rudyard Kipling and year: 1894
        let book = bookStore.createBook("Jungle Book", author: "Rudyard Kipling", year: 1894)
        
        //When saved to the database
        bookStore.saveBook(book)
        
        //Then we get find it by name and make sure the year is 1894
        let foundBooks = bookStore.findBooksByTitle("Jungle Book")
        XCTAssertEqual(foundBooks.count, 1)
        
        let firstBook = foundBooks.first
        XCTAssertEqual(firstBook?.year, 1894)
    }
    
    func testSaveAndUpdateBook() {
        
        do {
            //Given a book: Hamlet, William, 1599
            let hamletBook = bookStore.createBook("Hamlet", author: "William", year: 1599)
            bookStore.saveBook(hamletBook)
            
            try bookStore.updateBooks("author", currentValue: "William", updatedValue: "William Shakespear")
            
            //Then we find it again and make sure the author's name matches the new value
            let containsBook = bookStore.findBooksByTitle("Hamlet")
            XCTAssertNotNil(containsBook)
            XCTAssertEqual(containsBook.first!.author, "William Shakespear")
            
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
        
        
        
    }
    
    func testDelete() {
        // creating the book
        let book = bookStore.createBook("Interstellar", author: "Someone", year: 2014)
        bookStore.saveBook(book)
        
        // delete the book
        do {
            try bookStore.deleteBook(book)
        } catch {
            print("error trying to delete book")
        }
        
        // assert the  book is nil
        let foundBooks = bookStore.findBooksByTitle("Interstellar")
        XCTAssertNil(foundBooks.first)
    }


    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
