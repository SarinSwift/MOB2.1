import Foundation

@objc public class City: NSObject {
   @objc let name: String
    @objc let state: State
    
    public init(name: String, state: State) {
        self.name = name
        self.state = state
    }
    
    // description lets you pretty print this class' instances in the sidebar
    override public var description: String {
        return self.name
    }
}

@objc public class State: NSObject {
    @objc let name: String
    
    public init(name: String) {
        self.name = name
    }
    
    // description lets you pretty print this class' instances in the sidebar
    override public var description: String {
        return self.name
    }
}

// Must inherit from NSObject or NSPredicate will fail at runtime
@objc public class Person: NSObject {
    @objc let name: String
    @objc let age: Int
    @objc var city: City? = nil
    
    public init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    public convenience init(name: String, age: Int, city: City) {
        self.init(name: name, age: age)
        self.city = city
    }
    
    // description lets you pretty print this class' instances in the sidebar
    override public var description: String {
        if let city = self.city {
            return self.name + " - \(self.age) years old - \(city)"
        }
        return self.name + " - \(self.age) years old"
        
    }
}
