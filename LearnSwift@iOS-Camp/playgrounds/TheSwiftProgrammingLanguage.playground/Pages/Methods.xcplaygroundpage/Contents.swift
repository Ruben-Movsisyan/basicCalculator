//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Methods
//: Methods are functions that are associated with a particular type. \
//: _Classes_, _structures_, and _enumerations_ can all define **instance methods**, which encapsulate specific tasks and functionality for working with an instance of a given type. \
//: Classes, structures, and enumerations can also define **type methods**, which are associated with the type itself. Type methods are similar to _class_ methods in Objective-C.
//: ## Instance Methods
//: _Instance methods_ are functions that belong to instances of a particular class, structure, or enumeration. \
//: Instance methods have exactly the same syntax as functions. \
//: An instance method has implicit access to all other instance methods and properties of that type. \
//: An instance method can be called only on a specific instance of the type it belongs to. It cannot be called in isolation without an existing instance.
    class Counter {
        var count = 0
        func increment() {
            count += 1
        }
        func increment(by amount: Int) {
            count += amount
        }
        func reset() {
            count = 0
        }
    }

    let counter = Counter()

    counter.increment()

    counter.increment(by: 5)

    counter.reset()
//: ### The self Property
//: Every instance of a type has an implicit property called `self`. \
//: Use the `self` property to distinguish between the parameter name and the property name.
    struct Point {
        var x = 0.0, y = 0.0
        func isToTheRightOf(x: Double) -> Bool {
            return self.x > x
        }
    }

    let somePoint = Point(x: 4.0, y: 5.0)

    if somePoint.isToTheRightOf(x: 1.0) {
        print("This point is to the right of the line where x == 1.0")
    }
//: ### Modifying Value Types from Within Instance Methods
//: Structures and enumerations are _value types_. By default, the properties of a value type cannot be modified from within its instance methods.
//: You can opt in to _mutating_ behavior by placing the `mutating` keyword before the `func` keyword for that method:
    extension Point {
        mutating func moveBy(x deltaX: Double, y deltaY: Double) {
            x += deltaX
            y += deltaY
        }
    }

    var mutablePoint = Point(x: 1.0, y: 1.0)

    mutablePoint.moveBy(x: 2.0, y: 3.0)

    print("The point is now at (\(mutablePoint.x), \(mutablePoint.y))")
/*:
 - Note:
 You cannot call a mutating method on a constant of structure type, because its properties cannot be changed, even if they are variable properties.
 */
//: ### Assigning to self Within a Mutating Method
//: Mutating methods can assign an entirely new instance to the implicit `self` property:
    extension Point {
        
        mutating func moveByAlt1(x deltaX: Double, y deltaY: Double) {
            self = Point(x: x + deltaX, y: y + deltaY)
        }
    }
//: Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:
    enum TriStateSwitch {
        case off, low, high
        
        mutating func next() {
            switch self {
            case .off:
                self = .low
            case .low:
                self = .high
            case .high:
                self = .off
            }
        }
    }

    var ovenLight = TriStateSwitch.low

    ovenLight.next()

    ovenLight.next()
//: ## Type Methods
//: Define methods that are called on the type itself. These kinds of methods are called _type methods_. \
//: You indicate type methods by writing the `static` keyword before the method’s `func` keyword. \
//: Classes may also use the `class` keyword to allow subclasses to override the superclass’s.
/*:
 - Note:
 In Objective-C, you can define type-level methods only for Objective-C classes. \
 In Swift, you can define type-level methods for all classes, structures, and enumerations. \
 Each type method is explicitly scoped to the type it supports.
 */
    class SomeClass {
        class func someTypeMethod() {
            // type method implementation goes here
        }
    }
    SomeClass.someTypeMethod()
//: Within the body of a type method, the implicit `self` property refers to the type itself, rather than an instance of that type. \
//: More generally, any unqualified method and property names that you use within the body of a type method will refer to other type-level methods and properties. A type method can call another type method with the other method’s name, without needing to prefix it with the type name.
    struct LevelTracker {
        static var highestUnlockedLevel = 1
        var currentLevel = 1
        
        static func unlock(_ level: Int) {
            if level > highestUnlockedLevel {
                highestUnlockedLevel = level
            }
        }
        
        static func isUnlocked(_ level: Int) -> Bool {
            return level <= highestUnlockedLevel
        }
        
        @discardableResult
        mutating func advance(to level: Int) -> Bool {
            if LevelTracker.isUnlocked(level) {
                currentLevel = level
                return true
            } else {
                return false
            }
        }
    }

    class Player {
        var tracker = LevelTracker()
        let playerName: String
        func complete(level: Int) {
            LevelTracker.unlock(level + 1)
            tracker.advance(to: level + 1)
        }
        init(name: String) {
            playerName = name
        }
    }

    var player = Player(name: "Argyrios")
    player.complete(level: 1)
    print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

    player = Player(name: "Beto")
    if player.tracker.advance(to: 6) {
        print("player is now on level 6")
    } else {
        print("level 6 has not yet been unlocked")
    }
//:
//: [Next →](@next)
