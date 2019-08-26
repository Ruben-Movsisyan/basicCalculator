//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//: # Extensions
//: Extensions add new functionality to an existing class, structure, enumeration, or protocol type.
//:
//: This includes the ability to extend types for which you do not have access to the original source code (known as _retroactive modeling_).
//:
//: Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)
//:
//: **Extensions in Swift can:**
//: - Add computed instance properties and computed type properties
//: - Define instance methods and type methods
//: - Provide new initializers
//: - Define subscripts
//: - Define and use new nested types
//: - Make an existing type conform to a protocol
//:
//: In Swift, you can even extend a protocol to provide implementations of its requirements or add additional functionality that conforming types can take advantage of.
/*:
 - Note:
 Extensions can add new functionality to a type, but they cannot override existing functionality.
 */
//: ## Extension Syntax
//: Declare extensions with the extension keyword:
/*:
 - Example:
 ```
 extension SomeType {
    // new functionality to add to SomeType goes here
 }
 ```
 */
//: An extension can extend an existing type to make it adopt one or more protocols:
/*:
 - Example:
 ```
 extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
 }
 ```
 */
/*:
 - Note:
 If you define an extension to add new functionality to an existing type, the new functionality will be available on all existing instances of that type, even if they were created before the extension was defined.
 */
//: ## Computed Properties
//: Extensions can add computed instance properties and computed type properties to existing types.
    extension Double {
        var km: Double { return self * 1_000.0 }
        var m: Double { return self }
        var cm: Double { return self / 100.0 }
        var mm: Double { return self / 1_000.0 }
        var ft: Double { return self / 3.28084 }
    }

    let oneInch = 25.4.mm

    print("One inch is \(oneInch) meters")

    let threeFeet = 3.ft

    print("Three feet is \(threeFeet) meters")
//: These properties are read-only computed properties, and so they are expressed without the `get` keyword, for brevity.
//:
//: Their return value is of type `Double`, and can be used within mathematical calculations wherever a `Double` is accepted:
    let aMarathon = 42.km + 195.m

    print("A marathon is \(aMarathon) meters long")
/*:
 - Note:
 Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties.
 */
//: ## Initializers
//: Extensions can add new initializers to existing types.
//:
//: Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class.
//:
//: Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.
//:
//: If you use an extension to add an initializer to a value type that provides default values for all of its stored properties and does not define any custom initializers, you can call the default initializer and memberwise initializer for that value type from within your extension’s initializer. \
//: This wouldn’t be the case if you had written the initializer as part of the value type’s original implementation
//:
//: If you use an extension to add an initializer to a structure that was declared in another module, the new initializer can’t access self until it calls an initializer from the defining module.
    struct Size {
        var width = 0.0, height = 0.0
    }

    struct Point {
        var x = 0.0, y = 0.0
    }

    struct Rect {
        var origin = Point()
        var size = Size()
    }

    let defaultRect = Rect()

    let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                              size: Size(width: 5.0, height: 5.0))

    extension Rect {
        init(center: Point, size: Size) {
            let originX = center.x - (size.width / 2)
            let originY = center.y - (size.height / 2)
            self.init(origin: Point(x: originX, y: originY), size: size)
        }
    }

    let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                          size: Size(width: 3.0, height: 3.0))
/*:
 - Note:
 If you provide a new initializer with an extension, you are still responsible for making sure that each instance is fully initialized once the initializer completes.
 */
//: ## Methods
//: Extensions can add new instance methods and type methods to existing types.
    extension Int {
        func repetitions(task: () -> Void) {
            for _ in 0..<self {
                task()
            }
        }
    }

    3.repetitions {
        print("Hello!")
    }
//: ### Mutating Instance Methods
//: Instance methods added with an extension can also modify (or _mutate_) the instance itself.
//:
//: Structure and enumeration methods that modify `self` or its properties must mark the instance method as `mutating`, just like mutating methods from an original implementation.
    extension Int {
        mutating func square() {
            self = self * self
        }
    }

    var someInt = 3

    someInt.square()
//: ## Subscripts
//: Extensions can add new subscripts to an existing type.
//:
//: This subscript `[n]` returns the decimal digit `n` places in from the right of the number:
//: - `123456789[0]` returns `9`
//:
//: - `123456789[1]` returns `8`
//:
//: …and so on:
    extension Int {
        subscript(digitIndex: Int) -> Int {
            var decimalBase = 1
            for _ in 0..<digitIndex {
                decimalBase *= 10
            }
            return (self / decimalBase) % 10
        }
    }

//  876543210
    746381295[0]
//          👆

    746381295[1]
//         👆

    746381295[2]
//        👆

    746381295[8]
//  👆
//: ## Nested Types
//: Extensions can add new nested types to existing classes, structures, and enumerations:
    extension Int {
        enum Kind {
            case negative, zero, positive
        }
        
        var kind: Kind {
            switch self {
            case 0:
                return .zero
            case let x where x > 0:
                return .positive
            default:
                return .negative
            }
        }
    }
//: The nested enumeration can now be used with any Int value:
    func printIntegerKinds(_ numbers: [Int]) {
        for number in numbers {
            switch number.kind {
            case .negative:
                print("- ", terminator: "")
            case .zero:
                print("0 ", terminator: "")
            case .positive:
                print("+ ", terminator: "")
            }
        }
        
        print("")
    }

    printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
/*:
 - Note:
 `number.kind` is already known to be of type `Int.Kind`. Because of this, all of the `Int.Kind` case values can be written in shorthand form inside the `switch` statement, such as `.negative` rather than `Int.Kind.negative`.
 */
//: [Next →](@next)
