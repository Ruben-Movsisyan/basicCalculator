//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Optional Chaining
//: _Optional chaining_ is a process for querying and calling properties, methods, and subscripts on an optional that might currently be `nil`.
//:
//: Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is `nil`.
/*:
 - Note:
 Optional chaining in Swift is similar to messaging `nil` in Objective-C, but in a way that works for any type, and that can be checked for success or failure.
 */
//: ## Optional Chaining as an Alternative to Forced Unwrapping
//:
//: You specify optional chaining by placing a question mark (`?`) after the optional value on which you wish to call a property, method or subscript if the optional is non-`nil`.
//:
//: The result of an optional chaining call is of the same type as the expected return value, but wrapped in an optional. A property that normally returns an `Int` will return an `Int?` when accessed through optional chaining.
    class PersonExample {
        var residence: ResidenceExample?
    }

    class ResidenceExample {
        var numberOfRooms = 1
    }

    let somePerson = PersonExample()

/*:
 - Experiment:
 🧨 Uncomment the following lines to unveil the error:
 */
//    let roomCount = johnExample.residence!.numberOfRooms
//:
//: To use optional chaining, use a question mark in place of the exclamation mark:
    if let roomCount = somePerson.residence?.numberOfRooms {
        print("John's residence has \(roomCount) room(s).")
    } else {
        print("Unable to retrieve the number of rooms.")
    }
//:
    somePerson.residence = ResidenceExample()

    if let roomCount = somePerson.residence?.numberOfRooms {
        print("John's residence has \(roomCount) room(s).")
    } else {
        print("Unable to retrieve the number of rooms.")
    }
//: ## Defining Model Classes for Optional Chaining
//: You can use optional chaining with calls to properties, methods, and subscripts that are more than one level deep.
    class Person {
        var residence: Residence?
    }
//:
    class Residence {
        var rooms = [Room]()
        
        var numberOfRooms: Int {
            return rooms.count
        }
        
        subscript(i: Int) -> Room {
            get {
                return rooms[i]
            }
            set {
                rooms[i] = newValue
            }
        }
        
        var address: Address?
    }
//:
    class Room {
        let name: String
        
        init(name: String) { self.name = name }
    }
//:
    class Address {
        var buildingName: String?
        
        var buildingNumber: String?
        
        var street: String?
        
        func buildingIdentifier() -> String? {
            if let buildingNumber = buildingNumber, let street = street {
                return "\(buildingNumber) \(street)"
            } else if buildingName != nil {
                return buildingName
            } else {
                return nil
            }
        }
    }
//: ## Accessing Properties Through Optional Chaining
//: You can use optional chaining to access a property on an optional value, and to check if that property access is successful.
    let john = Person()

    if let roomCount = john.residence?.numberOfRooms {
        print("John's residence has \(roomCount) room(s).")
    } else {
        print("Unable to retrieve the number of rooms.")
    }
//: You can also attempt to set a property’s value through optional chaining:
    let someAddress = Address()

    someAddress.buildingNumber = "29"

    someAddress.street = "Acacia Road"

    john.residence?.address = someAddress
//:
    func createAddress() -> Address {
        print("Function was called.")
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        
        return someAddress
    }

    john.residence?.address = createAddress()
//: You can tell that the `createAddress()` function isn’t called, because nothing is printed.
//: ## Calling Methods Through Optional Chaining
//: You can use optional chaining to call a method on an optional value, and to check whether that method call is successful. You can do this even if that method does not define a return value.
    extension Residence {
        func printNumberOfRooms() {
            print("The number of rooms is \(numberOfRooms)")
        }
    }
//: This method does not specify a return type. However, functions and methods with no return type have an implicit return type of `Void`.
//:
//: This means that they return a value of `()`, or an empty tuple.
//:
//: If you call this method on an optional value with optional chaining, the method’s return type will be `Void?`, not `Void`, because return values are always of an optional type when called through optional chaining.
    if john.residence?.printNumberOfRooms() != nil {
        print("It was possible to print the number of rooms.")
    } else {
        print("It was not possible to print the number of rooms.")
    }


//: The same is true if you attempt to set a property through optional chaining.
//:
//: Any attempt to set a property through optional chaining returns a value of type `Void?`, which enables you to compare against `nil` to see if the property was set successfully:
    if (john.residence?.address = someAddress) != nil {
        print("It was possible to set the address.")
    } else {
        print("It was not possible to set the address.")
    }
//: ## Accessing Subscripts Through Optional Chaining
//: You can use optional chaining to try to retrieve and set a value from a subscript on an optional value, and to check whether that subscript call is successful.
/*:
 - Note:
 When you access a subscript on an optional value through optional chaining, you place the question mark _before_ the subscript’s brackets, not after. The optional chaining question mark always follows immediately after the part of the expression that is optional.
 */
    if let firstRoomName = john.residence?[0].name {
        print("The first room name is \(firstRoomName).")
    } else {
        print("Unable to retrieve the first room name.")
    }
//: Similarly, you can try to set a new value through a subscript with optional chaining:
    john.residence?[0] = Room(name: "Bathroom")
//: This subscript setting attempt also fails, because `residence` is currently `nil`.
    let johnsHouse = Residence()
    johnsHouse.rooms.append(Room(name: "Living Room"))
    johnsHouse.rooms.append(Room(name: "Kitchen"))

    john.residence = johnsHouse

    if let firstRoomName = john.residence?[0].name {
        print("The first room name is \(firstRoomName).")
    } else {
        print("Unable to retrieve the first room name.")
    }
//: ### Accessing Subscripts of Optional Type
//: If a subscript returns a value of optional type—such as the key subscript of Swift’s `Dictionary` type—place a question mark _after_ the subscript’s closing bracket to chain on its optional return value:
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]

    testScores["Dave"]?[0] = 91
    testScores["Bev"]?[0] += 1
    testScores["Brian"]?[0] = 72

    print(testScores)
//: ## Linking Multiple Levels of Chaining
//: You can link together multiple levels of optional chaining to drill down to properties, methods, and subscripts deeper within a model.
//:
//: However, multiple levels of optional chaining do not add more levels of optionality to the returned value.
//:
//: To put it another way:
//: - If the type you are trying to retrieve is not optional, it will become optional because of the optional chaining.
//: - If the type you are trying to retrieve is _already_ optional, it will _not_ become _more_ optional because of the chaining.
//:
//: Therefore:
//: - If you try to retrieve an `Int` value through optional chaining, an `Int?` is always returned, no matter how many levels of chaining are used.
//: - Similarly, if you try to retrieve an `Int?` value through optional chaining, an `Int?` is always returned, no matter how many levels of chaining are used.
    if let johnsStreet = john.residence?.address?.street {
        print("John's street name is \(johnsStreet).")
    } else {
        print("Unable to retrieve the address.")
    }
//:
    let johnsAddress = Address()
    johnsAddress.buildingName = "The Larches"
    johnsAddress.street = "Laurel Street"

    john.residence?.address = johnsAddress

    if let johnsStreet = john.residence?.address?.street {
        print("John's street name is \(johnsStreet).")
    } else {
        print("Unable to retrieve the address.")
    }
//: ## Chaining on Methods with Optional Return Values
//: You can also use optional chaining to call a method that returns a value of optional type, and to chain on that method’s return value if needed.
    if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
        print("John's building identifier is \(buildingIdentifier).")
    }
//: If you want to perform further optional chaining on this method’s return value, place the optional chaining question mark _after_ the method’s parentheses:
    if let beginsWithThe =
        john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
    }
/*:
 - Note:
 In the example above, you place the optional chaining question mark after the parentheses, because the optional value you are chaining on is the `buildingIdentifier()` method’s return value, and not the `buildingIdentifier()` method itself.
 */
//:
//: [Next →](@next)
