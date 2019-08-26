//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//: # Protocols
//: A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.
//:
//: The protocol can then be _adopted_ by a class, structure, or enumeration to provide an actual implementation of those requirements. \
//: Any type that satisfies the requirements of a protocol is said to _conform_ to that protocol.
//:
//: In addition to specifying requirements that conforming types must implement, you can extend a protocol to implement some of these requirements or to implement additional functionality that conforming types can take advantage of.
//:
//: ## Protocol Syntax
//: You define protocols in a very similar way to classes, structures, and enumerations:
/*:
 - Example:
 ```
 protocol SomeProtocol {
    // protocol definition goes here
 }
 ```
 */
//: Custom types state that they adopt a particular protocol by placing the protocol’s name after the type’s name, separated by a colon, as part of their definition:
/*:
 - Example:
 ```
 struct SomeStructure: FirstProtocol, AnotherProtocol {
    // structure definition goes here
 }
 ```
 */
//: If a class has a superclass, list the superclass name before any protocols it adopts, followed by a comma:
/*:
 - Example:
 ```
 class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // class definition goes here
 }
 ```
 */
//: ## Property Requirements
//: - A protocol can require any conforming type to provide an instance property or type property with a particular name and type.
//: - The protocol doesn’t specify whether the property should be a stored property or a computed property—it only specifies the required property name and type.
//: - The protocol also specifies whether each property must be gettable or gettable _and_ settable.
//: - If a protocol requires a property to be gettable and settable, that property requirement can’t be fulfilled by a constant stored property or a read-only computed property.
//: - If the protocol only requires a property to be gettable, the requirement can be satisfied by any kind of property, and it’s valid for the property to be also settable if this is useful for your own code.
//: - Property requirements are always declared as variable properties, prefixed with the `var` keyword.
//: - Gettable and settable properties are indicated by writing `{ get set }` after their type declaration, and gettable properties are indicated by writing `{ get }`.
/*:
 - Example:
 ```
 protocol SomeProtocol {
     var mustBeSettable: Int { get set }
     var doesNotNeedToBeSettable: Int { get }
 }
 ```
 */
//: Always prefix _type property_ requirements with the `static` keyword when you define them in a protocol.
//:
//: This rule pertains even though type property requirements can be prefixed with the `class` or `static` keyword when implemented by a class:
/*:
 - Example:
 ```
 protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
 }
 ```
 */
//: Here’s an example of a protocol with a single instance property requirement:
    protocol FullyNamed {
        var fullName: String { get }
    }
//: Here’s an example of a simple structure that adopts and conforms to the `FullyNamed` protocol:
    struct PersonExample: FullyNamed {
        var fullName: String
    }

    let john = PersonExample(fullName: "John Appleseed")
//: Here’s a more complex class, which also adopts and conforms to the `FullyNamed` protocol:
    class Starship: FullyNamed {
        var prefix: String?
        var name: String
        
        init(name: String, prefix: String? = nil) {
            self.name = name
            self.prefix = prefix
        }
        
        var fullName: String {
            return (prefix != nil ? prefix! + " " : "") + name
        }
    }

    var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

    ncc1701.fullName
//: ## Method Requirements
//: Protocols can require specific instance methods and type methods to be implemented by conforming types. \
//: These methods are written as part of the protocol’s definition in exactly the same way as for normal instance and type methods, but without curly braces or a method body.
//:
//: Variadic parameters are allowed, subject to the same rules as for normal methods.
//:
//: Default values, however, can’t be specified for method parameters within a protocol’s definition.
//:
//: As with type property requirements, you always prefix _type method_ requirements with the `static` keyword when they’re defined in a protocol. \
//: This is true even though type method requirements are prefixed with the `class` or `static` keyword when implemented by a class:
/*:
 - Example:
 ```
 protocol SomeProtocol {
    static func someTypeMethod()
 }
 ```
 */
//: The following example defines a protocol with a single instance method requirement:
    protocol RandomNumberGenerator {
        func random() -> Double
    }
//: This class implements a pseudorandom number generator algorithm known as a _linear congruential generator_:
    class LinearCongruentialGenerator: RandomNumberGenerator {
        var lastRandom = 42.0
        let m = 139968.0
        let a = 3877.0
        let c = 29573.0
        
        func random() -> Double {
            lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
            return lastRandom / m
        }
    }

    let generator = LinearCongruentialGenerator()

    print("Here's a random number: \(generator.random())")

    print("And another one: \(generator.random())")
//: ## Mutating Method Requirements
//: It’s sometimes necessary for a method to modify (or _mutate_) the instance it belongs to.
//:
//: If you define a protocol instance method requirement that is intended to mutate instances of any type that adopts the protocol, mark the method with the `mutating` keyword as part of the protocol’s definition.
/*:
 - Note:
If you mark a protocol instance method requirement as `mutating`, you don’t need to write the `mutating` keyword when writing an implementation of that method for a _class_. \
The `mutating` keyword is only used by _structures and enumerations_.
 */
    protocol Togglable {
        mutating func toggle()
    }

    enum OnOffSwitch: Togglable {
        case off, on
        
        mutating func toggle() {
            switch self {
            case .off:
                self = .on
            case .on:
                self = .off
            }
        }
    }

    var lightSwitch = OnOffSwitch.off

    lightSwitch.toggle()
//: ## Initializer Requirements
//: Protocols can require specific initializers to be implemented by conforming types.
//:
//: You write these initializers as part of the protocol’s definition in exactly the same way as for normal initializers, but without curly braces or an initializer body:
/*:
 - Example:
 ```
 protocol SomeProtocol {
    init(someParameter: Int)
 }
 ```
 */
//: ### Class Implementations of Protocol Initializer Requirements
//: You can implement a protocol initializer requirement on a conforming class as either a designated initializer or a convenience initializer.
//:
//: In both cases, you must mark the initializer implementation with the `required` modifier:
/*:
 - Example:
 ```
 class SomeClass: SomeProtocol {
     required init(someParameter: Int) {
        // initializer implementation goes here
     }
 }
 ```
 */
//: The use of the `required` modifier ensures that you provide an explicit or inherited implementation of the initializer requirement on all subclasses of the conforming class, such that they also conform to the protocol.
/*:
 - Note:
 You don’t need to mark protocol initializer implementations with the `required` modifier on classes that are marked with the `final` modifier, because final classes can’t subclassed.
 */
//: If a subclass overrides a designated initializer from a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the `required` and `override` modifiers:
/*:
 - Example:
 ```
 protocol SomeProtocol {
     init()
 }
 
 class SomeSuperClass {
     init() {
        // initializer implementation goes here
     }
 }
 
 class SomeSubClass: SomeSuperClass, SomeProtocol {
     // "required" from SomeProtocol conformance; "override" from SomeSuperClass
     required override init() {
        // initializer implementation goes here
     }
 }
 ```
 */
//: ### Failable Initializer Requirements
//: Protocols can define failable initializer requirements for conforming types. \
//: A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. \
//: A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer.
//:
//: ## Protocols as Types
//: Protocols don’t actually implement any functionality themselves.
//:
//: Nonetheless, any protocol you create will become a fully-fledged type for use in your code.
//:
//: Because it’s a type, you can use a protocol in many places where other types are allowed, including:
//: - As a parameter type or return type in a function, method, or initializer
//: - As the type of a constant, variable, or property
//: - As the type of items in an array, dictionary, or other container
/*:
 - Note:
 Because protocols are types, begin their names with a capital letter (such as `FullyNamed` and `RandomNumberGenerator`) to match the names of other types in Swift (such as `Int`, `String`, and `Double`).
 */
//: Here’s an example of a protocol used as a type:
    class Dice {
        let sides: Int
        let generator: RandomNumberGenerator
        
        init(sides: Int, generator: RandomNumberGenerator) {
            self.sides = sides
            self.generator = generator
        }
        
        func roll() -> Int {
            return Int(generator.random() * Double(sides)) + 1
        }
    }

    var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

    for _ in 1...5 {
        print("Random dice roll is \(d6.roll())")
    }
//: ## Delegation
//: _Delegation_ is a design pattern that enables a class or structure to hand off (or _delegate_) some of its responsibilities to an instance of another type. \
//: This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated. \
//: Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source. \
//: The example below defines two protocols for use with dice-based board games:
    protocol DiceGame {
        var dice: Dice { get }
        
        func play()
    }

    protocol DiceGameDelegate: AnyObject {
        func gameDidStart(_ game: DiceGame)
        func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
        func gameDidEnd(_ game: DiceGame)
    }
//: Here’s a version of the _Snakes and Ladders_ game:
//:
//: ![Snakes and Ladders](snakesAndLadders_2x.png "Snakes and Ladders")
//:
    class SnakesAndLadders: DiceGame {
        let finalSquare = 25
        let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
        var square = 0
        var board: [Int]
        
        init() {
            board = Array(repeating: 0, count: finalSquare + 1)
            board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
            board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        }
        
        weak var delegate: DiceGameDelegate?
        
        func play() {
            square = 0
            delegate?.gameDidStart(self)
            
            gameLoop: while square != finalSquare {
                let diceRoll = dice.roll()
                delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
                
                switch square + diceRoll {
                case finalSquare:
                    break gameLoop
                case let newSquare where newSquare > finalSquare:
                    continue gameLoop
                default:
                    square += diceRoll
                    square += board[square]
                }
            }
            
            delegate?.gameDidEnd(self)
        }
    }
//: This next example shows a class called `DiceGameTracker`, which adopts the `DiceGameDelegate` protocol:
    class DiceGameTracker: DiceGameDelegate {
        var numberOfTurns = 0
        
        func gameDidStart(_ game: DiceGame) {
            numberOfTurns = 0
            if game is SnakesAndLadders {
                print("Started a new game of Snakes and Ladders")
            }
            print("The game is using a \(game.dice.sides)-sided dice")
        }
        
        func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
            numberOfTurns += 1
            print("Rolled a \(diceRoll)")
        }
        
        func gameDidEnd(_ game: DiceGame) {
            print("The game lasted for \(numberOfTurns) turns")
        }
    }
//: Here’s how `DiceGameTracker` looks in action:
    let tracker = DiceGameTracker()
    let game = SnakesAndLadders()
    game.delegate = tracker
    game.play()
//: ## Adding Protocol Conformance with an Extension
//: You can extend an existing type to adopt and conform to a new protocol, even if you don’t have access to the source code for the existing type.
//:
//: Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand.
/*:
 - Note:
 Existing instances of a type automatically adopt and conform to a protocol when that conformance is added to the instance’s type in an extension.
 */
//: For example, this protocol, called `TextRepresentable`, can be implemented by any type that has a way to be represented as text:
    protocol TextRepresentable {
        var textualDescription: String { get }
    }

    extension Dice: TextRepresentable {
        var textualDescription: String {
            return "A \(sides)-sided dice"
        }
    }
//: Any `Dice` instance can now be treated as `TextRepresentable`:
    let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())

    print(d12.textualDescription)
//: Similarly, the `SnakesAndLadders` game class can be extended to adopt and conform to the `TextRepresentable` protocol:
    extension SnakesAndLadders: TextRepresentable {
        var textualDescription: String {
            return "A game of Snakes and Ladders with \(finalSquare) squares"
        }
    }

    print(game.textualDescription)
//: ### Conditionally Conforming to a Protocol
//: A generic type may be able to satisfy the requirements of a protocol only under certain conditions, such as when the type’s generic parameter conforms to the protocol.
//: You can make a generic type conditionally conform to a protocol by listing constraints when extending the type.
//:
//: Write these constraints after the name of the protocol you’re adopting by writing a generic `where` clause.
    extension Array: TextRepresentable where Element: TextRepresentable {
        var textualDescription: String {
            let itemsAsText = self.map { $0.textualDescription }
            return "[" + itemsAsText.joined(separator: ", ") + "]"
        }
    }

    let myDice = [d6, d12]

    print(myDice.textualDescription)
//: ### Declaring Protocol Adoption with an Extension
//: If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:
    struct Hamster {
        var name: String
        var textualDescription: String {
            return "A hamster named \(name)"
        }
    }

    extension Hamster: TextRepresentable {}

    let simonTheHamster = Hamster(name: "Simon")

    let somethingTextRepresentable: TextRepresentable = simonTheHamster

    print(somethingTextRepresentable.textualDescription)
/*:
 - Note:
 Types don’t automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol.
 */
//: ## Collections of Protocol Types
//: A protocol can be used as the type to be stored in a collection such as an array or a dictionary:
    let things: [TextRepresentable] = [game, d12, simonTheHamster]

    for thing in things {
        print(thing.textualDescription)
    }
//: ## Protocol Inheritance
//: A protocol can _inherit_ one or more other protocols and can add further requirements on top of the requirements it inherits.
//:
//: The syntax for protocol inheritance is similar to the syntax for class inheritance, but with the option to list multiple inherited protocols, separated by commas:
/*:
 - Example:
 ```
 protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
 }
 ```
 */
//: Here’s an example of a protocol that inherits the `TextRepresentable` protocol from above:
    protocol PrettyTextRepresentable: TextRepresentable {
        var prettyTextualDescription: String { get }
    }
//: The `SnakesAndLadders` class can be extended to adopt and conform to `PrettyTextRepresentable`:
    extension SnakesAndLadders: PrettyTextRepresentable {
        var prettyTextualDescription: String {
            var output = textualDescription + ":\n"
            
            for index in 1...finalSquare {
                switch board[index] {
                case let ladder where ladder > 0:
                    output += "▲ "
                case let snake where snake < 0:
                    output += "▼ "
                default:
                    output += "○ "
                }
            }
            return output
        }
    }

    print(game.prettyTextualDescription)
//: ## Class-Only Protocols
//: You can limit protocol adoption to class types (and not structures or enumerations) by adding the `AnyObject` protocol to a protocol’s inheritance list:
/*:
 - Example:
 ```
 protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    // class-only protocol definition goes here
 }
 ```
 */
/*:
 - Note:
 Use a class-only protocol when the behavior defined by that protocol’s requirements assumes or requires that a conforming type has reference semantics rather than value semantics.
 */
//: ## Protocol Composition
//: It can be useful to require a type to conform to multiple protocols at the same time. \
//: You can combine multiple protocols into a single requirement with a _protocol composition_. \
//: Protocol compositions behave as if you defined a temporary local protocol that has the combined requirements of all protocols in the composition. \
//: Protocol compositions don’t define any new protocol types. \
//: Protocol compositions have the form `SomeProtocol & AnotherProtocol`. \
//: You can list as many protocols as you need, separating them with ampersands (`&`). \
//: In addition to its list of protocols, a protocol composition can also contain one class type, which you can use to specify a required superclass.
//:
//: _Documentation Example:_ [`Codable`](https://developer.apple.com/documentation/swift/codable).
    protocol Named {
        var name: String { get }
    }

    protocol Aged {
        var age: Int { get }
    }

    struct Person: Named, Aged {
        var name: String
        var age: Int
    }

    func wishHappyBirthday(to celebrator: Named & Aged) {
        print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
    }

    let birthdayPerson = Person(name: "Malcolm", age: 21)

    wishHappyBirthday(to: birthdayPerson)
//: Here’s an example that combines the `Named` protocol from the previous example with a `Location` class:
    class Location {
        var latitude: Double
        var longitude: Double
        
        init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }

    class City: Location, Named {
        var name: String
        
        init(name: String, latitude: Double, longitude: Double) {
            self.name = name
            super.init(latitude: latitude, longitude: longitude)
        }
    }

    func beginConcert(in location: Location & Named) {
        print("Hello, \(location.name)!")
    }

    let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
    beginConcert(in: seattle)
//: ## Checking for Protocol Conformance
//: You can use the `is` and `as` operators to check for protocol conformance, and to cast to a specific protocol.
//:
//: Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a type:
//: - The is operator returns `true` if an instance conforms to a protocol and returns `false` if it doesn’t.
//: - The `as?` version of the downcast operator returns an optional value of the protocol’s type, and this value is `nil` if the instance doesn’t conform to that protocol.
//: - The `as!` version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast doesn’t succeed.
//:
//: This example defines a protocol called `HasArea`, with a single property requirement of a gettable `Double` property called `area`:
    protocol HasArea {
        var area: Double { get }
    }
//: Here are two classes, `Circle` and `Country`, both of which conform to the `HasArea` protocol:
    class Circle: HasArea {
        let pi = 3.1415927
        var radius: Double
        var area: Double { return pi * radius * radius }
        
        init(radius: Double) { self.radius = radius }
    }

    class Country: HasArea {
        var area: Double
        
        init(area: Double) { self.area = area }
    }
//: Here’s a class called `Animal`, which doesn’t conform to the `HasArea` protocol:
    class Animal {
        var legs: Int
        
        init(legs: Int) { self.legs = legs }
    }
//: The `Circle`, `Country` and `Animal` classes don’t have a shared base class. Nonetheless, they’re all classes, and so instances of all three types can be used to initialize an array that stores values of type `AnyObject`:
    let objects: [AnyObject] = [
        Circle(radius: 2.0),
        Country(area: 243_610),
        Animal(legs: 4)
    ]
//: The `objects` array can now be iterated, and each object in the array can be checked to see if it conforms to the `HasArea` protocol:
    for object in objects {
        if let objectWithArea = object as? HasArea {
            print("Area is \(objectWithArea.area)")
        } else {
            print("Something that doesn't have an area")
        }
    }
//: Note that the underlying objects aren’t changed by the casting process. They continue to be a `Circle`, a `Country` and an `Animal`.
//: However, at the point that they’re stored in the `objectWithArea` constant, they’re only known to be of type `HasArea`, and so only their area property can be accessed.
//: ## Optional Protocol Requirements
//: You can define _optional requirements_ for protocols, These requirements don’t have to be implemented by types that conform to the protocol.
//:
//: - Optional requirements are prefixed by the `optional` modifier as part of the protocol’s definition.
//: - Optional requirements are available so that you can write code that interoperates with Objective-C.
//: - Both the protocol and the optional requirement must be marked with the `@objc` attribute.
//: - Note that `@objc` protocols can be adopted only by classes that inherit from Objective-C classes or other `@objc` classes.
//: - They can’t be adopted by structures or enumerations.
//:
//: When you use a method or property in an optional requirement, its type automatically becomes an optional. For example, a method of type `(Int) -> String` becomes `((Int) -> String)?`. Note that the entire function type is wrapped in the optional, not the method’s return value.
//:
//: An optional protocol requirement can be called with optional chaining, to account for the possibility that the requirement was not implemented by a type that conforms to the protocol.
//:
//: You check for an implementation of an optional method by writing a question mark after the name of the method when it’s called, such as `someOptionalMethod?(someArgument)`.
//: The following example defines an integer-counting class called `Counter`, which uses an external data source to provide its increment amount. This data source is defined by the `CounterDataSource` protocol, which has two optional requirements:
    import Foundation

    @objc protocol CounterDataSource {
        @objc optional func increment(forCount count: Int) -> Int
        @objc optional var fixedIncrement: Int { get }
    }
/*:
 - Note:
 Strictly speaking, you can write a custom class that conforms to `CounterDataSource` without implementing either protocol requirement. They’re both optional, after all. Although technically allowed, this wouldn’t make for a very good data source.
 */
    class Counter {
        var count = 0
        var dataSource: CounterDataSource?
        
        func increment() {
            if let amount = dataSource?.increment?(forCount: count) {
                count += amount
            } else if let amount = dataSource?.fixedIncrement {
                count += amount
            }
        }
    }
//: Here’s a simple `CounterDataSource` implementation where the data source returns a constant value of 3 every time it’s queried. It does this by implementing the optional `fixedIncrement` property requirement:
    class ThreeSource: NSObject, CounterDataSource {
        let fixedIncrement = 3
    }
//: You can use an instance of `ThreeSource` as the data source for a new `Counter` instance:
    var counter = Counter()
    counter.dataSource = ThreeSource()

    for _ in 1...4 {
        counter.increment()
        print(counter.count)
    }
//: Here’s a more complex data source called `TowardsZeroSource`, which makes a `Counter` instance count up or down towards zero from its current `count` value:
    class TowardsZeroSource: NSObject, CounterDataSource {
        func increment(forCount count: Int) -> Int {
            if count == 0 {
                return 0
            } else if count < 0 {
                return 1
            } else {
                return -1
            }
        }
    }

    counter.count = -4
    counter.dataSource = TowardsZeroSource()

    for _ in 1...5 {
        counter.increment()
        print(counter.count)
    }
//: ## Protocol Extensions
//: Protocols can be extended to provide method, initializer, subscript, and computed property implementations to conforming types.
//: This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.
//:
//: For example, the `RandomNumberGenerator` protocol can be extended to provide a `randomBool()` method, which uses the result of the required `random()` method to return a random `Bool` value:
    extension RandomNumberGenerator {
        func randomBool() -> Bool {
            return random() > 0.5
        }
    }

    let gen = LinearCongruentialGenerator()

    print("Here's a random number: \(gen.random())")

    print("And here's a random Boolean: \(gen.randomBool())")
//: Protocol extensions can add implementations to conforming types but can’t make a protocol extend or inherit from another protocol.
//:
//: Protocol inheritance is always specified in the protocol declaration itself.
//: ### Providing Default Implementations
//: You can use protocol extensions to provide a default implementation to any method or computed property requirement of that protocol.
//:
//: If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.
/*:
 - Note:
 Protocol requirements with default implementations provided by extensions are distinct from optional protocol requirements. Although conforming types don’t have to provide their own implementation of either, requirements with default implementations can be called without optional chaining.
 */
    extension PrettyTextRepresentable  {
        var prettyTextualDescription: String {
            return textualDescription
        }
    }
//: ### Adding Constraints to Protocol Extensions
//: When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available.
//:
//: You write these constraints after the name of the protocol you’re extending by writing a generic `where` clause.
//:
//: For example, you can define an extension to the `Collection` protocol that applies to any collection whose elements conform to the `Equatable` protocol.
//:
//: By constraining a collection’s elements to the `Equatable` protocol, a part of the standard library, you can use the `==` and `!=` operators to check for equality and inequality between two elements.
    extension Collection where Element: Equatable {
        func allEqual() -> Bool {
            for element in self {
                if element != self.first {
                    return false
                }
            }
            return true
        }
    }

    let equalNumbers = [100, 100, 100, 100, 100]

    let differentNumbers = [100, 100, 200, 100, 200]

    print(equalNumbers.allEqual())

    print(differentNumbers.allEqual())
/*:
 - Note:
 If a conforming type satisfies the requirements for multiple constrained extensions that provide implementations for the same method or property, Swift uses the implementation corresponding to the most specialized constraints.
 */
//: [Next →](@next)
