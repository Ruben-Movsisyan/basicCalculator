//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Inheritance
//: A class can _inherit_ methods, properties, and other characteristics from another class.
//:
//: When one class inherits from another, the inheriting class is known as a _subclass_, and the class it inherits from is known as its _superclass_.
//:
//: Inheritance is a fundamental behavior that differentiates classes from other types in Swift.
//:
//: Classes in Swift can call and access methods, properties, and subscripts belonging to their superclass and can provide their own _overriding_ versions of those methods, properties, and subscripts to refine or modify their behavior.
//:
//: Classes can also add property observers to inherited properties in order to be notified when the value of a property changes.
//: ## Defining a Base Class
//: Any class that does not inherit from another class is known as a _base class_.
/*:
 - Note:
Swift classes do not inherit from a universal base class.\
\
Classes you define without specifying a superclass automatically become base classes for you to build upon.
 */
//: The example below defines a base class called `Vehicle`:
    class Vehicle {
        var currentSpeed = 0.0
        
        var description: String {
            return "traveling at \(currentSpeed) miles per hour"
        }
        
        func makeNoise() {
            // do nothing - an arbitrary vehicle doesn't necessarily make a noise
        }
    }
//: Create a new instance of `Vehicle` with _initializer syntax_:
    let someVehicle = Vehicle()
//: Access its `description` property to print a human-readable description:
    print("Vehicle: \(someVehicle.description)")
//: ## Subclassing
//: _Subclassing_ is the act of basing a new class on an existing class.
//:
//: The subclass inherits characteristics from the existing class, which you can then refine.
//:
//: You can also add new characteristics to the subclass.
//: The following example defines a subclass called `Bicycle`, with a superclass of `Vehicle`:
    class Bicycle: Vehicle {
        var hasBasket = false
    }
//: The new `Bicycle` class automatically gains all of the characteristics of `Vehicle`, such as its `currentSpeed` and `description` properties and its `makeNoise()` method.
    let bicycle = Bicycle()

    bicycle.hasBasket = true
//: Modify the inherited `currentSpeed` property:
    bicycle.currentSpeed = 15.0

    print("Bicycle: \(bicycle.description)")
//: Subclasses can themselves be subclassed.
//:
//: The next example creates a subclass of `Bicycle` for a two-seater bicycle known as a “tandem”:
    class Tandem: Bicycle {
        var currentNumberOfPassengers = 0
    }

    let tandem = Tandem()

    tandem.hasBasket = true
    tandem.currentNumberOfPassengers = 2
    tandem.currentSpeed = 22.0

    print("Tandem: \(tandem.description)")
//: ## Overriding
//: A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass.
//:
//: This is known as _overriding_.
//:
//: Prefix your overriding definition with the `override` keyword.
//: ### Accessing Superclass Methods, Properties, and Subscripts
//: Access the superclass version of a method, property, or subscript by using the `super` prefix:
/*:
 - Example:
`super.someMethod()` \
`super.someProperty()` \
`super[someIndex]`
 */
//: ### Overriding Methods
    class Train: Vehicle {
        override func makeNoise() {
            print("Choo Choo")
        }
    }

    let train = Train()

    train.makeNoise()
//: ### Overriding Properties
//: You can override an inherited instance or type property to provide your own _custom getter and setter_ for that property.
//:
//: Or add _property observers_ to enable the overriding property to observe when the underlying property value changes.
//: #### Overriding Property Getters and Setters
//: You can provide a _custom getter_ (and _setter_, if appropriate) to override any _inherited property_, regardless of whether the inherited property is implemented as a _stored_ or _computed_ property at source.
//:
//: The stored or computed nature of an inherited property is _not known by a subclass_ — it only knows that the inherited property has a certain name and type.
//:
//: You must always state both the _name_ and the _type_ of the property you are overriding, to enable the compiler to check that your override matches a superclass property with the same name and type.
//:
//: You can present an _inherited read-only_ property as a _read-write_ property by providing both a getter and a setter in your subclass property override.
//:
//: You cannot, however, present an inherited read-write property as a read-only property.
/*:
 - Note:
If you provide a setter as part of a property override, you must also provide a getter for that override.\
\
If you don’t want to modify the inherited property’s value within the overriding getter, you can simply pass through the inherited value by returning `super.someProperty` from the getter.
 */
    class Car: Vehicle {
        var gear = 1
        override var description: String {
            return super.description + " in gear \(gear)"
        }
    }

    let car = Car()

    car.currentSpeed = 25.0

    car.gear = 3

    print("Car: \(car.description)")
//: #### Overriding Property Observers
//: You can use property overriding to add property observers to an inherited property.
//:
//: This enables you to be notified when the value of an inherited property changes, regardless of how that property was originally implemented.
/*:
 - Note:
You cannot add property observers to inherited _constant stored_ properties or inherited _read-only computed_ properties. The value of these properties _cannot be set_, and so it is not appropriate to provide a `willSet` or `didSet` implementation as part of an override. \
\
You cannot provide both an overriding setter and an overriding property observer for the same property. \
If you want to observe changes to a property’s value, and you are already providing a custom setter for that property, you can simply observe any value changes from within the custom setter.
 */
    class AutomaticCar: Car {
        override var currentSpeed: Double {
            didSet {
                gear = Int(currentSpeed / 10.0) + 1
            }
        }
    }

    let automatic = AutomaticCar()

    automatic.currentSpeed = 35.0

    print("AutomaticCar: \(automatic.description)")
//: ## Preventing Overrides
//: Prevent a method, property, or subscript from being overridden by marking it as _final_.
//: Do this by writing the final modifier before the method, property, or subscript’s introducer keyword:
//: * `final var`
//: * `final func`
//: * `final class func`
//: * `final subscript`
//:
//: Any attempt to override a final method, property, or subscript in a subclass is reported as a _compile-time error_.
//:
//: Methods, properties, or subscripts in class extension can also be marked as `final` within the extension’s definition.
//:
//: You can mark an entire class as final by writing the `final` modifier before the `class` keyword in its class definition (`final class`).
//:
//: Any attempt to subclass a final class is reported as a compile-time error.
//:
//: [Next →](@next)
