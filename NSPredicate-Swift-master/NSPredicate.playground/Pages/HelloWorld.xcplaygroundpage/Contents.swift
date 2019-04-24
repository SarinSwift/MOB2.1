//: [Previous](@previous)
/*:

## NSPredicate Hello World

Given the Person class:
*/
import Foundation

@objc class APerson: NSObject {    // Must inherit from NSObject or NSPredicate will fail at runtime
    @objc let name: String
    @objc let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // description lets you pretty print this class' instances in the sidebar
    override var description: String {
        return self.name + " - \(self.age) years old"
    }
}

/*:

and a bunch of People

*/

let groucho = APerson(name: "Groucho", age: 50)
let chicco  = APerson(name: "Chicco", age: 61)
let harpo   = APerson(name: "Harpo", age: 45)
let zeppo   = APerson(name: "Zeppo", age: 61)

let people: NSArray = [groucho, chicco, harpo, zeppo]
// using a NSArray here because predicates work with them, not with regular Swift Arrays

/*:

we can get __all people of age == 61__ with a simple predicate

*/

// 'age' must be spelled the same as the variable
let allAge61 = NSPredicate(format: "age = 61")

people.filtered(using: allAge61)

/*:

we can also __filter by name__

*/


let namesPredicate = NSPredicate(format: "name = 'Harpo'")

people.filtered(using: namesPredicate)


/*:

💻 __Your turn__: try to filter all people aged 50 years old, then everyone called _Zeppo_

*/

let age50OrOlder = NSPredicate(format: "age >= 50")
people.filtered(using: age50OrOlder)

let calledZeppo = NSPredicate(format: "name = 'Zeppo'")
people.filtered(using: calledZeppo)
/*:

💻 __SOME DESTRUCTIVE FUN__: remove the NSObject parent class from Person and see what happens (__save before__)

*/


/*:

💻 More destructive fun__: change the NSArray from people, to create a Swift Array and see what happens
*/



/*:

💻 You can use `=` or `==` in comparisons. Try it

*/



//: [Next](@next)
