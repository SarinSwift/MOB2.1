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

