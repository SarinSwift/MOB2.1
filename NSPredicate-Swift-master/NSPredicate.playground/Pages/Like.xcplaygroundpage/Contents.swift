//: [Previous](@previous)

/*:

# Like & BeginsWith: allows for simple String pattern matching

*/

import Foundation

class Province: NSObject {    // Must inherit from NSObject
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    // description lets you pretty print this class' instances in the sidebar
    override var description: String {
        return self.name
    }
}

let cadiz = Province(name: "Cádiz")
let malaga = Province(name: "Málaga")
let logrono = Province(name: "Logroño")
let madrid = Province(name: "Madrid")
let lugo = Province(name: "lugo")


let provinces: NSArray = [cadiz, malaga, logrono, madrid, lugo]

/*:
To filter all provinces starting with 'M'
*/

let provincesStartingWithM = NSPredicate(format: "name like 'M*'")

provinces.filtered(using: provincesStartingWithM)
let provincesStartingWithMA = NSPredicate(format: "name like 'Ma*'")
provinces.filtered(using: provincesStartingWithMA)

/*:

To filter correctly all provinces starting with Ma, regardless of accents, we use [d]
[d] means ignore diacritics, which are all funny accented characters

*/

let provincesStartingWithMA2 = NSPredicate(format: "name like [d] 'Ma*'")
provinces.filtered(using: provincesStartingWithMA2)

/*:

Also, to ignore Case, we use [c]

*/


let provincesStartingWithMACaseDiacritics = NSPredicate(format: "name like [cd] 'l*'")
provinces.filtered(using: provincesStartingWithMACaseDiacritics)


/*:

💻 __EXERCISE__: filter provinces to show all with names ending in _d_

*/






/*:

## BEGINSWITH


- BEGINSWITH: The left-hand expression begins with the right-hand expression
- CONTAINS: The left-hand expression contains the right-hand expression
- ENDSWITH: The left-hand expression ends with the right-hand expression

__No wildcars allowed (*, ?) using BEGINSWITH__

*/


let provincesbeginningWithMACaseDiacritics = NSPredicate(format: "name BEGINSWITH[cd] 'l'")
provinces.filtered(using: provincesbeginningWithMACaseDiacritics)


/*:

💻 __EXERCISE__: filter provinces to show all with names ending in _o_

*/






//: [Next](@next)
