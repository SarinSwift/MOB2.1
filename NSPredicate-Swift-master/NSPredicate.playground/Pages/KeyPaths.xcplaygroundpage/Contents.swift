//: [Previous](@previous)


/*:
# Keypaths

A keypath is, as its name implies, a way to traverse your object graph from object to object. For example, if you have a Person class and every person lives in a different Town, you can get the town's name using `somePerson.city.cityName`

*/

import Foundation

let sfState = State(name: "California")
let nyState = State(name: "New York")

let sf = City(name: "San Francisco", state: sfState)
let nyc = City(name: "New York", state: nyState)

let groucho = Person(name: "Groucho", age: 50, city: nyc)
let chicco = Person(name: "Chicco", age: 61, city: nyc)
let harpo = Person(name: "Harpo", age: 45, city: sf)
let zeppo = Person(name: "Zeppo", age: 61, city: sf)


let people: NSArray = [groucho, chicco, harpo, zeppo]

/*:

Filter all people who lives in San Francisco, using a KeyPath

*/

let allInSF = NSPredicate(format: "%K = %@", "city.name", "San Francisco")
people.filtered(using: allInSF)


/*:

💻 __EXERCISE__: filter all people living in New York

*/

let allInNY = NSPredicate(format: "%K = %@", "city.name", "New York")
people.filtered(using: allInNY)

/*:

💻 __EXERCISE__: add a new class (State) with property name. Add State to the city. Filter all people living in the California State

*/

let allInCalState = NSPredicate(format: "%K = %@", "city.state.name", "California")
people.filtered(using: allInCalState)

//: [Solved exercise - try to do it, it's better 😉](Solutions)


//: [Next](@next)
