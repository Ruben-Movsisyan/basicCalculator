//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Properties
//: _Properties_ associate values with a particular class, structure, or enumeration. \
//: _Stored properties_ store constant and variable values as part of an instance, whereas _computed properties_ calculate (rather than store) a value.
//: * Stored properties are provided only by classes and structures.
//: * Computed properties are provided by classes, structures, and enumerations. \
//: Stored and computed properties are usually associated with instances of a particular type. \
//: However, properties can also be associated with the type itself. Such properties are known as _type properties_. \
//: In addition, you can define _property observers_ to monitor changes in a property’s value, which you can respond to with custom actions. \
//: Property observers can be added to stored properties you define yourself, and also to properties that a subclass inherits from its superclass.
//: ## Stored Properties
//: A stored property is a constant or variable that is stored as part of an instance of a particular class or structure. \
//: Stored properties can be either _variable stored properties_ (introduced by the `var` keyword) or _constant stored properties_ (introduced by the `let` keyword).
    struct FixedLengthRange {
        var firstValue: Int
        let length: Int
    }

    var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)

    rangeOfThreeItems.firstValue = 6
//: ### Stored Properties of Constant Structure Instances
//: If you create an instance of a structure and assign that instance to a constant, you cannot modify the instance’s properties, even if they were declared as variable properties:
//:
//: 🧨 _uncomment following lines to see the error_
//:
//    let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//
//    rangeOfFourItems.firstValue = 6
//: This behavior is due to structures being _value types_. When an instance of a value type is marked as a constant, so are all of its properties. \
//: The same is not true for classes, which are _reference types_. If you assign an instance of a reference type to a constant, you can still change that instance’s variable properties.
//: ### Lazy Stored Properties
//: A _lazy stored property_ is a property whose initial value is not calculated until the first time it is used. \
//: You indicate a lazy stored property by writing the `lazy` modifier before its declaration.
//: - - -
//: ✏️ You must always declare a lazy property as a variable (with the `var` keyword), because its initial value might not be retrieved until after instance initialization completes. \
//: Constant properties must always have a value before initialization completes, and therefore cannot be declared as lazy.
//: - - -
//: - - -
//: ✏️ Lazy properties are useful when the initial value for a property is dependent on outside factors whose values are not known until after an instance’s initialization is complete. \
//: Lazy properties are also useful when the initial value for a property requires complex or computationally expensive setup that should not be performed unless or until it is needed.
//: - - -
    class DataImporter {
        /*
         DataImporter is a class to import data from an external file.
         The class is assumed to take a nontrivial amount of time to initialize.
         */
        var filename = "data.txt"
        // the DataImporter class would provide data importing functionality here
    }

    class DataManager {
        lazy var importer = DataImporter()
        var data = [String]()
        // the DataManager class would provide data management functionality here
    }

    let manager = DataManager()
    manager.data.append("Some data")
    manager.data.append("Some more data")

    print(manager.importer.filename)
    // the DataImporter instance for the importer property has now been created
//: - - -
//: ✏️ If a property marked with the `lazy` modifier is accessed by multiple threads simultaneously and the property has not yet been initialized, there is no guarantee that the property will be initialized only once.
//: - - -
//: ### Stored Properties and Instance Variables
//: In Objective-C, besides properties, you can use instance variables as a backing store for the values stored in a property. \
//: A Swift property does not have a corresponding instance variable, and the backing store for a property is not accessed directly.
//: ## Computed Properties
//: Classes, structures, and enumerations can define _computed properties_, which do not actually store a value. \
//: Instead, they provide a _getter_ and an _optional setter_ to retrieve and set other properties and values indirectly.
    struct Point {
        var x = 0.0, y = 0.0
    }

    struct Size {
        var width = 0.0, height = 0.0
    }

    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + (size.width / 2)
                let centerY = origin.y + (size.height / 2)
                return Point(x: centerX, y: centerY)
            }
            set(newCenter) {
                origin.x = newCenter.x - (size.width / 2)
                origin.y = newCenter.y - (size.height / 2)
            }
        }
    }

    var square = Rect(origin: Point(x: 0.0, y: 0.0),
                      size: Size(width: 10.0, height: 10.0))
    let initialSquareCenter = square.center
    square.center = Point(x: 15.0, y: 15.0)
    print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
//:
//: ![Computed Properties](computedProperties_2x.png "Updating computed center property")
//:
//: ### Shorthand Setter Declaration
//: If a computed property’s setter does not define a name for the new value to be set, a default name of `newValue` is used.
    struct AlternativeRect {
        var origin = Point()
        var size = Size()
        var center: Point {
            get {
                let centerX = origin.x + (size.width / 2)
                let centerY = origin.y + (size.height / 2)
                return Point(x: centerX, y: centerY)
            }
            set {
                origin.x = newValue.x - (size.width / 2)
                origin.y = newValue.y - (size.height / 2)
            }
        }
    }
//: ### Read-Only Computed Properties
//: A computed property with a getter but no setter is known as a _read-only computed property_. \
//: A read-only computed property always returns a value, and can be accessed through dot syntax, but cannot be set to a different value.
//: - - -
//: ✏️ You must declare computed properties—including read-only computed properties—as variable properties with the `var` keyword, because their value is not fixed. \
//: The `let` keyword is only used for constant properties, to indicate that their values cannot be changed once they are set as part of instance initialization.
//: - - -
//: Simplify the declaration of a read-only computed property by removing the `get` keyword and its braces:
    struct Cuboid {
        var width = 0.0, height = 0.0, depth = 0.0
        var volume: Double {
            return width * height * depth
        }
    }

    let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)

    print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
//: ## Property Observers
//: _Property observers_ observe and respond to changes in a property’s value. \
//: Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value. \
//: You can add property observers to any stored properties you define, except for lazy stored properties. \
//: You can also add property observers to any inherited property (whether stored or computed) by overriding the property within a subclass. \
//: You don’t need to define property observers for nonoverridden computed properties, because you can observe and respond to changes to their value in the computed property’s setter. \
//: You have the option to define either or both of these observers on a property:
//: * `willSet` is called just before the value is stored.
//: * `didSet` is called immediately after the new value is stored. \
//: If you implement a `willSet` observer, it’s passed the new property value as a constant parameter. You can specify a name for this parameter as part of your `willSet` implementation. If you don’t write the parameter name and parentheses within your implementation, the parameter is made available with a default parameter name of `newValue`. \
//: Similarly, if you implement a `didSet` observer, it’s passed a constant parameter containing the old property value. You can name the parameter or use the default parameter name of `oldValue`. If you assign a value to a property within its own `didSet` observer, the new value that you assign replaces the one that was just set.
//: - - -
//: ✏️ The `willSet` and `didSet` observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They are not called while a class is setting its own properties, before the superclass initializer has been called.
//: - - -
//: Here’s an example of `willSet` and `didSet` in action:
    class StepCounter {
        var totalSteps: Int = 0 {
            willSet(newTotalSteps) {
                    print("About to set totalSteps to \(newTotalSteps)")
            }
            didSet {
                if totalSteps > oldValue  {
                    print("Added \(totalSteps - oldValue) steps")
                }
            }
        }
    }

    let stepCounter = StepCounter()
    stepCounter.totalSteps = 200

    stepCounter.totalSteps = 360

    stepCounter.totalSteps = 896
//: - - -
//: ✏️ If you pass a property that has observers to a function as an in-out parameter, the `willSet` and `didSet` observers are always called. \
//: This is because of the _copy-in copy-out_ memory model for in-out parameters: The value is always written back to the property at the end of the function.
//: - - -
//: ## Global and Local Variables
//: The capabilities for computing and observing properties are available to global variables and local variables.
//: * Global variables are variables that are defined outside of any function, method, closure, or type context.
//: * Local variables are variables that are defined within a function, method, or closure context. \
//: However, you can also define computed variables and define observers for stored variables, in either a global or local scope. Computed variables calculate their value, rather than storing it, and they are written in the same way as computed properties.
//: - - -
//: ✏️ Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables do not need to be marked with the lazy modifier. \
//: Local constants and variables are never computed lazily.
//: - - -
//: ## Type Properties
//: Instance properties are properties that belong to an instance of a particular type. Every time you create a new instance of that type, it has its own set of property values, separate from any other instance. \
//: You can also define properties that belong to the type itself, not to any one instance of that type. There will only ever be one copy of these properties, no matter how many instances of that type you create. These kinds of properties are called _type properties_.
//: - - -
//: ✏️ Unlike stored instance properties, you must always give stored type properties a default value. This is because the type itself does not have an initializer that can assign a value to a stored type property at initialization time. \
//: Stored type properties are lazily initialized on their first access. They are guaranteed to be initialized only once, even when accessed by multiple threads simultaneously, and they do not need to be marked with the `lazy` modifier.
//: - - -
//: ### Type Property Syntax
//: In C and Objective-C, you define static constants and variables associated with a type as _global_ static variables. \
//: In Swift, however, type properties are written as part of the type’s definition, within the type’s outer curly braces, and each type property is explicitly scoped to the type it supports. \
//: Define type properties with the `static` keyword. \
//: For computed type properties for class types, you can use the `class` keyword instead to allow subclasses to override the superclass’s implementation.
    struct SomeStructure {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 1
        }
    }

    enum SomeEnumeration {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 6
        }
    }

    class SomeClass {
        static var storedTypeProperty = "Some value."
        static var computedTypeProperty: Int {
            return 27
        }
        class var overrideableComputedTypeProperty: Int {
            return 107
        }
    }
//: - - -
//: ✏️ The computed type property examples above are for read-only computed type properties, but you can also define read-write computed type properties with the same syntax as for computed instance properties.
//: - - -
//: ### Querying and Setting Type Properties
//: Type properties are queried and set on the _type_, not on an instance of that type:
    print(SomeStructure.storedTypeProperty)

    SomeStructure.storedTypeProperty = "Another value."
    print(SomeStructure.storedTypeProperty)

    print(SomeEnumeration.computedTypeProperty)

    print(SomeClass.computedTypeProperty)
//:
//: [Next →](@next)
