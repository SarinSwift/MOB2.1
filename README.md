# Persistence
**Persisting small amounts of data**  
- Plist
- UserDefaults


## Propert List (plist files)
[Project work](https://github.com/SarinSwift/MOB2.1/tree/master/PracticePropertyList)  
A property list contains key-value data  
A common plist file is Info.plist: contains essential configuration information  
Contents are structured using xml where the root is always either an array or a dictionary.  

**Saving values to plist**  
- edit from the plist file  
- Change keys and values

**Reading values from plist** 
```
var format = PropertyListSerialization.PropertyListFormat.xml
var data: [String: AnyObject] = [:]
let path: String? = Bundle.main.path(forResource: "new", ofType: "plist")!
let xmlContents = FileManager.default.contents(atPath: path!)!
do {
  // we use &format here to explicitly note that we're using the variable format above and not a copy of it!
  data = try PropertyListSerialization.propertyList(from: xmlContents, options: .mutableContainersAndLeaves, format: &format) as! [String : AnyObject]
} catch {
  print("Error reading plist: \(error)")
}
```

**Writing to a plist** 
- This allows us to write to the file without having to manually add new elements to the plist  
- CAN'T write to our app bundle
- Main bundle can only be read from but not written to
- Document directory is where everything the user generates is stored
- Write smaller helper methods. [Suggested](https://stackoverflow.com/questions/25100262/save-data-to-plist-file-in-swift) stack overflow answer



## UserDefaults  
[Project work](https://github.com/SarinSwift/MOB2.1/tree/master/UserDefaultsPractice)  
The UserDefaults class is thread-safe.  
Allows to store data such as Strings, Numbers, Dates, Data, Arrays, Dictionaries.  
Should only be used for storing very small amounts of data.  
Every data is saved through a unique key. So if we save things with the same key, it will only replace the old data.  
Setting and getting is simple:  
```
// Set
UserDefaults.standard.set("Sarin", forKey: "username")  
// Get
let name = UserDefaults.standard.string(forKey: "username") ?? ""     
```
We can create a helper struct to handle our UserDefaults functionality  
The model should mainly contain  
-save token method  
-get token method  
-clear data method 


## Keychain
[Project work](https://github.com/SarinSwift/MOB2.1/tree/master/LearningKeychains)  
Is great for persisting(encrypting) sensitive data such as passwords, credit card info  
Keychain provides easy access to encrypted data  
What is it?  
  An API that gives an app the ability to store user data in an encrypted database   
  Items in the keychain are containers that is shared through the OS(operating system)  
  
**Pro's:**  
  - Share keychain items between apps because items stored belongs to the OS  
  - Items persist even when app is deleted  
  - Do not need to call to backend just to simply get the password   
  - Doesn't prompt the user everytime we need data (bad user experience)    
  
**Con's:**   
  - Stores only simple key-value objects not complex ones  
  - Deleting the app will not delete the data in keychain. Only clearing the keychain on developer side will

**How does it work?**  
&nbsp; Every item is composed of item(data we can not see), and attributes(things we call on to get to the actual data that is encrypted)  
  
**Keychain use case:**  
&nbsp; Open the app -> looking for password -> authenticate when found -> success  
  
**Some terms:**
  - SecKeychain (database)
  - SecKeychainItem (item which is saved to the database)
  - SecItemDelete (deleting an item)
  - SecItemAdd (adding an item)
  
  
## CoreData
[Project work](https://github.com/SarinSwift/MOB2.1/tree/master/FriendsCoreData) - simple updating and deleting from coredata  
[Project work](https://github.com/SarinSwift/MOB2.1/tree/master/NSPredicate-Swift-master) - playgrounds for NSPredictes  
[Project work](https://github.com/SarinSwift/MOB2.1/tree/master/WorldCup) - implementation with NSFetchedResultsController

CoreData is not a DataBase but a persistence framework  

**The core data stack**  
Contains 3 tools:  
1. Managed Object Model  
2. Persistece Store Coordinator  
3. Managed Object Context  

Manages:  
Persistence,  
Background data tasks,  
View synchronizations (in charge of letting views and data be in synch with addition or deletions)

**Core data components**  
1. Object graph: Abstract structure that can be used to describe an app's state at a particular part in time.  
2. NSManagedObject: Contains the entity description  
3. NSManagedObjectContext: This contains many NSManagedObjects. You MUST create / instantiate this NSManagedObjectContext before you are able to use any CoreData functionality (save / fetch / delete data)  
4. NSPersistentStoreCoordinator: Coordinates between NSManagedObject and the Store   
5. NSPersistentStore: Maps between records in the store and objects in your app   
6. NSManagedObjectModel: Describes all NSManagedObjects  
7. NSPersistentContainer: Encapsulates entire coredata stack (biggest picture)

**Fetching from Core Data**  

***NSFetchRequest***  
We can fetch entities from core data by creating an instance of the NSFetchRequest.  
Use NSFetchRequest's convenience initializer for easy code and simple input of the entity name.  

***Sort Descriptors***  
Sort descriptors allows us to sort information from our fetchRequest in whatever order we specify.  
Initializing a sort descriptor ⤵  
``` 
let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
fetchRequest.sortDescriptors = [sortDescriptor]
```

***NSFetchedResultsController***  
This is not a view controller!  
Allows updating and changing our table views to be easy from performing queries to core data  
The steps you should complete ⤵⤵⤵  
1. Initialize our fetch request  
2. Add our sort descriptors (optional)
3. Add our predicates (optional)
4. Initialize our fetchResultsController with the fetchRequest and managedObjectContext
5. Set FetchedResultsController.self = delegate
6. Implement our delegate FetchedResultsController methods (optional)
7. Update so our numberOfRowsInSection, and cellForRowAt to use fetched results 
8. Fetch from FetchedResultsController and reload data. Prbably in self.viewWillAppear



# Tests
[Project work](https://github.com/SarinSwift/MOB2.1/tree/master/LearningToUseTests)  
**A software testing where individual units/components are tested to validate that each unit(method) performs as planned**  
**XCTest: Xcode's built in framework for testing**   

Things we can test:  
-Models  
-Methods  
-Interaction with viewcontrollers  
-UI workflows  

## Benefits of unit testing
-Increases the pace of development for rolling out new features from the current code   
-Makes sure that the new features will not break our existing code  
-Detect bugs early and fix them faster  
-Saves time, resource, and money  
-Allows you to not have the app crash on every new update  
-Refactoring is easier and gives you more confidence to improve without breaking  
 


Can reasonably say that Unit testing is: 
1. A set of automated/coded testing 
2. Part of a coding process
3. Is all about code health(maintainability)
4. Does NOT prove that your application works

## Test Covergae
**Should we reach 100% test coverage?**  
No because:  
-It's expensive to reach the 100% test coverage  
-Does not mean the code is perfect!  
-Probably not worth the effort neyond a certain point  
However, the critical code must be covered at almost 100%  

## UI Testing 
Recording interactions within the apps UI objects with queries, synthesizing events, then sending them to those objects.

## TDD
The methedology of writing tests before any supporting code.  
The tests provide documentation on how the developer wants the app to behave
Tests and code go hand-in-hand so it results in better code coverage  
Developers have an easier time when it comes to major refactoring in the future
