//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Structures and Classes
//: Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code. \
//: You define properties and methods to add functionality to your structures and classes using the same syntax you use to define constants, variables, and functions. \
//: Unlike other programming languages, Swift doesn’t require you to create separate interface and implementation files for custom structures and classes. In Swift, you define a structure or class in a _single file_, and the external interface to that class or structure is automatically made available for other code to use.
//: - - -
//: ✏️ An instance of a class is traditionally known as an _object_. However, Swift structures and classes are much closer in functionality than in other languages, and much of this chapter describes functionality that applies to instances of _either_ a class or a structure type. Because of this, the more general term _instance_ is used.
//: - - -
//: ## Comparing Structures and Classes
//: **Structures and classes** in Swift have many things in common. Both can:
//: * Define **properties** to store values
//: * Define **methods** to provide functionality
//: * Define **subscripts** to provide access to their values using subscript syntax
//: * Define **initializers** to set up their initial state
//: * Be extended to expand their functionality beyond a default implementation
//: * **Conform to protocols** to provide standard functionality of a certain kind \
//: **Classes** have additional capabilities that structures don’t have:
//: * **Inheritance** enables one class to inherit the characteristics of another.
//: * **Type casting** enables you to check and interpret the type of a class instance at runtime.
//: * **Deinitializers** enable an instance of a class to free up any resources it has assigned.
//: * **Reference counting** allows more than one reference to a class instance.
//: - - -
//: ✏️ The additional capabilities that classes support come at the cost of increased complexity. \
//: As a general guideline, prefer structures because they’re easier to reason about, and use classes when they’re appropriate or necessary. \
//: In practice, this means most of the custom data types you define will be structures and enumerations.
//: - - -
//: ### Definition Syntax
//: Introduce structures with the `struct` keyword and classes with the `class` keyword:
    struct SomeStructure {
        // structure definition goes here
    }

    class SomeClass {
        // class definition goes here
    }
//: - - -
//: ✏️ Whenever you define a new structure or class, you define a new Swift type. \
//: Give types `UpperCamelCase` names (such as `SomeStructure` and `SomeClass` here) to match the capitalization of standard Swift types (such as `String`, `Int`, and `Bool`). \
//: Give properties and methods `lowerCamelCase` names (such as `frameRate` and `incrementCount`) to differentiate them from type names.
//: - - -
    struct Resolution {
        var width = 0
        var height = 0
    }

    class VideoMode {
        var resolution = Resolution()
        var interlaced = false
        var frameRate = 0.0
        var name: String?
    }
//: ### Structure and Class Instances
//: The syntax for creating instances is very similar for both structures and classes:
    let someResolution = Resolution()

    let someVideoMode = VideoMode()
//: ### Accessing Properties
//: Access the properties of an instance using _dot syntax_:
    print("The width of someResolution is \(someResolution.width)")
//: Drill down into subproperties, such as the `width` property in the `resolution` property of a `VideoMode`:
    print("The width of someVideoMode is \(someVideoMode.resolution.width)")
//: Also use dot syntax to assign a new value to a variable property:
    someVideoMode.resolution.width = 1280

    print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
//: ### Memberwise Initializers for Structure Types
//: All structures have an automatically generated _memberwise initializer_:
    let vga = Resolution(width: 640, height: 480)
//: ## Structures and Enumerations Are Value Types
//: A _value type_ is a type whose value is _copied_ when it’s assigned to a variable or constant, or when it’s passed to a function.
//: - - -
//: ✏️ In fact, all of the basic types in Swift—integers, floating-point numbers, Booleans, strings, arrays and dictionaries—are value types, and are implemented as structures behind the scenes.
//: - - -
//: All structures and enumerations are value types in Swift.
//: - - -
//: ✏️ Collections defined by the standard library like arrays, dictionaries, and strings use an optimization to reduce the performance cost of copying. \
//: Instead of making a copy immediately, these collections share the memory where the elements are stored between the original instance and any copies. If one of the copies of the collection is modified, the elements are copied just before the modification. \
//: The behavior you see in your code is always as if a copy took place immediately.
//: - - -
//: Consider this example:
    let hd = Resolution(width: 1920, height: 1080)

    var cinema = hd
//: Because `Resolution` is a structure, a _copy_ of the existing `hd` instance is made, and this new copy is assigned to `cinema`. \
//: Even though `hd` and `cinema` now have the same width and height, they are two completely different instances behind the scenes. \
//: Next, the `width` property of `cinema` is amended to be the width of the slightly wider 2K standard:
    cinema.width = 2048
//: Checking the `width` property of cinema shows that it has indeed changed to be `2048`:
    print("cinema is now \(cinema.width) pixels wide")
//: However, the `width` property of the original hd instance still has the old value of `1920`:
    print("hd is still \(hd.width) pixels wide")
//: \
//: ![Struct Shared State](sharedStateStruct_2x.png) \
//: The same behavior applies to enumerations:
    enum CompassPoint {
        case north, south, east, west
        mutating func turnNorth() {
            self = .north
        }
    }

    var currentDirection = CompassPoint.west

    let rememberedDirection = currentDirection

    currentDirection.turnNorth()

    print("The current direction is \(currentDirection)")

    print("The remembered direction is \(rememberedDirection)")
//: ## Classes Are Reference Types
//: Unlike value types, _reference types_ are not copied when they are assigned to a variable or constant, or when they are passed to a function. \
//: Rather than a copy, a reference to the same existing instance is used. \
//: Here’s an example, using the `VideoMode` class defined above:
    let tenEighty = VideoMode()

    tenEighty.resolution = hd
    tenEighty.interlaced = true
    tenEighty.name = "1080i"
    tenEighty.frameRate = 25.0

    let alsoTenEighty = tenEighty
    alsoTenEighty.frameRate = 30.0
//: `tenEighty` and `alsoTenEighty` both refer to the same `VideoMode` instance: \
//: ![Class Shared State](sharedStateClass_2x.png) \
    print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
//: - - -
//: ✏️ `tenEighty` and alsoTenEighty are declared as constants, rather than variables. However, you can still change tenEighty.frameRate and alsoTenEighty.frameRate \
//: The values of the `tenEighty` and `alsoTenEighty` constants themselves don’t actually change. `tenEighty` and `alsoTenEighty` themselves don’t “store” the `VideoMode` instance—instead, they both _refer_ to a `VideoMode` instance behind the scenes. It’s the `frameRate` property of the underlying `VideoMode` that is changed, not the values of the constant references to that `VideoMode`.
//: - - -
//: ### Identity Operators
//: It can sometimes be useful to find out whether two constants or variables refer to exactly the same instance of a class. To enable this, Swift provides two identity operators:
//: * Identical to (`===`)
//: * Not identical to (`!==`)
    if tenEighty === alsoTenEighty {
        print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
    }
//: ### Pointers
//: If you have experience with C, C++, or Objective-C, you may know that these languages use _pointers_ to refer to addresses in memory. \
//: A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C, but isn’t a direct pointer to an address in memory, and doesn’t require you to write an asterisk (`*`) to indicate that you are creating a reference.
//:
//: [Next →](@next)
