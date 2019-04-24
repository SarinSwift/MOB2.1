//: [Previous](@previous)
/*:

# Using variables in our predicates

*/

import Foundation

// Person class defined in Person.swift (inside this Playground's global  Sources Folder)

let groucho = Person(name: "Groucho", age: 50)
let chicco = Person(name: "Chicco", age: 61)
let harpo = Person(name: "Harpo", age: 45)
let zeppo = Person(name: "Zeppo", age: 61)

let people: NSArray = [groucho, chicco, harpo, zeppo]


/*:

We can use format parameters:

- %d: numbers
- %@: var arg substitution for an object value

*/

let allAge61 = NSPredicate(format: "age = %d", 61)  // 61 is just a number, not an Object
people.filtered(using: allAge61)


let allAge61Object = NSPredicate(format: "age = %@", NSNumber(value: 61)) // 61 here is @61: NSNumber
people.filtered(using: allAge61Object)

/*:

💻 __EXERCISE__: as Strings are objects, filter the person with name Groucho

*/

let grouchoName = "Groucho"
let grouchoNames = NSPredicate(format: "name = %@", grouchoName)
people.filtered(using: grouchoNames)


/*:

💻 __EXERCISE__: filter all people aged equal or over 50

*/

let age = 50
let allAgeOver50 = NSPredicate(format: "age >= %i", age)
people.filtered(using: allAgeOver50)


//: [Next](@next)
