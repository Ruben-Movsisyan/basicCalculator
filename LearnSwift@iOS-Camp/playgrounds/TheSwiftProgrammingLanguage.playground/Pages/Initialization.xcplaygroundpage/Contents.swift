//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Initialization
//: _Initialization_ is the process of preparing an instance of a class, structure, or enumeration for use.
//:
//: This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.
//:
//: You implement this initialization process by defining _initializers_, which are like special methods that can be called to create a new instance of a particular type.
//:
//: Unlike Objective-C initializers, Swift initializers do not return a value.
//:
//: Instances of class types can also implement a _deinitializer_, which performs any custom cleanup just before an instance of that class is deallocated.
//:
//: ## Setting Initial Values for Stored Properties
//: Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created.
//:
//: Stored properties cannot be left in an indeterminate state.
//:
//: You can set an initial value for a stored property within an initializer, or by assigning a _default property value_ as part of the property’s definition.
/*:
 - Note:
 When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any _property observers_.
 */
//: ### Initializers
//: Initializers are called to create a new instance of a particular type.
//:
//: In its simplest form, an initializer is like an instance method with no parameters, written using the `init` keyword.
    struct Fahrenheit {
        var temperature: Double
        
        init() {
            temperature = 32.0
        }
    }

    var f = Fahrenheit()

    print("The default temperature is \(f.temperature)° Fahrenheit")
//: ### Default Property Values
//: You can set the initial value of a stored property from within an initializer, as shown above.
//:
//: Alternatively, specify a default property value as part of the property’s declaration:
    struct FahrenheitVar2 {
        var temperature = 32.0
    }
/*:
 - Note:
If a property always takes the same initial value, provide a default value rather than setting a value within an initializer. \
The end result is the same, but the default value ties the property’s initialization more closely to its declaration. \
It makes for shorter, clearer initializers and enables you to infer the type of the property from its default value.
 */
//: ## Customizing Initialization
//: You can customize the initialization process as described in the following sections.
//: ### Initialization Parameters
//: You can provide _initialization parameters_ as part of an initializer’s definition:
    struct Celsius {
        var temperatureInCelsius: Double
        
        init(fromFahrenheit fahrenheit: Double) {
            temperatureInCelsius = (fahrenheit - 32.0) / 1.8
        }
        
        init(fromKelvin kelvin: Double) {
            temperatureInCelsius = kelvin - 273.15
        }
    }

    let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)

    let freezingPointOfWater = Celsius(fromKelvin: 273.15)

//: ### Parameter Names and Argument Labels
//: Initializers do not have an identifying function name before their parentheses in the way that functions and methods do.
//:
//: The names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called.
    struct Color {
        let red, green, blue: Double
        
        init(red: Double, green: Double, blue: Double) {
            self.red   = red
            self.green = green
            self.blue  = blue
        }
        
        init(white: Double) {
            red   = white
            green = white
            blue  = white
        }
    }

    let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)

    let halfGray = Color(white: 0.5)
/*:
 - Note:
Swift provides an automatic argument label for every parameter in an initializer if you don’t provide one.
 */
//:
//: 🧨 _uncomment following lines to see the error_
//:
//    let veryGreen = Color(0.0, 1.0, 0.0)
//: ### Initializer Parameters Without Argument Labels
//: If you do not want to use an argument label for an initializer parameter, write an underscore (`_`) instead
    struct CelsiusVar2 {
        var temperatureInCelsius: Double
        init(fromFahrenheit fahrenheit: Double) {
            temperatureInCelsius = (fahrenheit - 32.0) / 1.8
        }
        init(fromKelvin kelvin: Double) {
            temperatureInCelsius = kelvin - 273.15
        }
        init(_ celsius: Double) {
            temperatureInCelsius = celsius
        }
    }

    let bodyTemperature = CelsiusVar2(37.0)

    bodyTemperature.temperatureInCelsius
//: ### Optional Property Types
//: If your custom type has a stored property that is logically allowed to have “no value” — declare the property with an _optional_ type.
//:
//: Properties of optional type are automatically initialized with a value of `nil`.
    class SurveyQuestion {
        var text: String // This can be a constant as well (see next for further explanation).
        
        var response: String?
        
        init(text: String) {
            self.text = text
        }
        
        func ask() {
            print(text)
        }
    }

    let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")

    cheeseQuestion.ask()

    cheeseQuestion.response = "Yes, I do like cheese."
//: ### Assigning Constant Properties During Initialization
//: You can assign a value to a constant property at any point during initialization, as long as it is set to a definite value by the time initialization finishes.
//:
//: Once a constant property is assigned a value, it can’t be further modified.
/*:
 - Note:
For class instances, a constant property can be modified during initialization only by the class that introduces it. It cannot be modified by a subclass.
 */
//: You can revise the `SurveyQuestion` example from above to use a _constant property_ rather than a variable property for the `text` property of the question, to indicate that the question does not change once an instance of `SurveyQuestion` is created.
//: ## Default Initializers
//: Swift provides a _default initializer_ for any structure or class that provides default values for all of its properties and does not provide at least one initializer itself.
//: The default initializer simply creates a new instance with all of its properties set to their default values.
    class ShoppingItem {
        var name: String?
        
        var quantity = 1
        
        var purchased = false
    }

    var item = ShoppingItem()
//: ### Memberwise Initializers for Structure Types
//: Structure types automatically receive a _memberwise initializer_ if they do not define any of their own custom initializers.
//:
//: The `Size` structure automatically receives an `init(width:height:)` memberwise initializer:
    struct Size {
        var width = 0.0, height = 0.0
    }

    let twoByTwo = Size(width: 2.0, height: 2.0)
//: ### Initializer Delegation for Value Types
//: Initializers can call other initializers to perform part of an instance’s initialization. This process, known as _initializer delegation_, avoids duplicating code across multiple initializers.
//:
//: Value types (structures and enumerations) do not support inheritance, and so their initializer delegation process is relatively simple, because they can only delegate to another initializer that they provide themselves.
//:
//: Classes, which support inheritance, have additional responsibilities for ensuring that all stored properties they inherit are assigned a suitable value during initialization.
/*:
 - Note:
If you define a custom initializer for a value type, you will no longer have access to the default initializer (or the memberwise initializer, if it is a structure) for that type.\
 \
If you want your custom value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an _extension_ rather than as part of the value type’s original implementation.
 */
    struct Point {
        var x = 0.0, y = 0.0
    }

    struct Rect {
        var origin = Point()
        
        var size = Size()
        
        init() {}
        
        init(origin: Point, size: Size) {
            self.origin = origin
            self.size = size
        }
        
        init(center: Point, size: Size) {
            let originX = center.x - (size.width / 2)
            let originY = center.y - (size.height / 2)
            self.init(origin: Point(x: originX, y: originY), size: size)
        }
    }

    let basicRect = Rect()

    let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))

    let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                          size: Size(width: 3.0, height: 3.0))

//: ## Class Inheritance and Initialization
//: All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.
//:
//: Swift defines two kinds of initializers for class types, these are _designated initializers_ and _convenience initializers_.
//:
//: ### Designated Initializers and Convenience Initializers
//: _Designated initializers_ are the primary initializers for a class.
//:
//: A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
//:
//: Classes tend to have very few designated initializers, and it is quite common for a class to have only one.
//:
//: Designated initializers are “funnel” points through which initialization takes place, and through which the initialization process continues up the superclass chain.
//:
//: Every class must have _at least one_ designated initializer. In some cases, this requirement is satisfied by _inheriting_ one or more designated initializers from a superclass.
//:
//: \
//: _Convenience initializers_ are secondary, supporting initializers for a class.
//:
//: Define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values.
//:
//: Also define a convenience initializer to create an instance of that class for a specific use case or input value type.
//:
//: You do not have to provide convenience initializers if your class does not require them.
//:
//: Create convenience initializers whenever a shortcut to a common initialization pattern will save time or make initialization of the class clearer in intent.
//: ### Syntax for Designated and Convenience Initializers
//: Designated initializers are written in the following way:
/*:
 * Callout(Example):
```
init(parameters) {
    statements
}
```
 */
//: Convenience initializers are writter in the following way:
/*:
 - Example:
 ```
 convenience init(parameters) {
    statements
 }
 ```
 */
//: ### Initializer Delegation for Class Types
//: To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
//:
//: **Rule 1**
//: - A designated initializer must call a designated initializer from its immediate _superclass_.
//:
//: **Rule 2**
//: - A convenience initializer must call another initializer from the _same class_.
//:
//: **Rule 3**
//: - A convenience initializer must ultimately call a designated initializer.
//:
//: A simple way to remember this is:
//:
//: - Designated initializers must always delegate _up_.
//: - Convenience initializers must always delegate _across_.
//:
//: These rules are illustrated in the figure below:
//:
//: ![Initializer Delegation](initializerDelegation01_2x.png)
//:
/*:
 - Note:
These rules don’t affect how users of your classes create instances of each class. \
Any initializer in the diagram above can be used to create a fully-initialized instance of the class they belong to. \
The rules only affect how you write the implementation of the class’s initializers.
 */
//: The figure below shows a more complex class hierarchy for four classes. It illustrates how the designated initializers in this hierarchy act as “funnel” points for class initialization:
//:
//:
//: ![Complex Initializer Delegation](initializerDelegation02_2x.png)
//:
//: ### Two-Phase Initialization
//: Class initialization in Swift is a two-phase process.
//:
//: **Initialization Phase 1**
//: - In the first phase, each stored property is assigned an initial value by the class that introduced it.
//:
//: **Initialization Phase 2**
//: - In the second phase, each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use.
//:
//: Two-phase initialization process makes initialization safe, while still giving complete flexibility to each class in a class hierarchy.
//:
//: It prevents property values from being accessed before they are initialized, and prevents property values from being set to a different value by another initializer unexpectedly.
/*:
 - Note:
Swift’s two-phase initialization process is similar to initialization in Objective-C. The main difference is that during phase 1, Objective-C assigns zero or null values (such as `0` or `nil`) to every property. \
Swift’s initialization flow is more flexible in that it lets you set custom initial values, and can cope with types for which `0` or `nil` is not a valid default value.
 */
//: Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:
//:
//: **Safety check 1**
//: - A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer.
//:
//: **Safety check 2**
//: - A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property. If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.
//:
//: **Safety check 3**
//: - A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class). If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.
//:
//: **Safety check 4**
//: - An initializer cannot call any instance methods, read the values of any instance properties, or refer to `self` as a value until after the first phase of initialization is complete.
//:
//: \
//: Here’s how two-phase initialization plays out, based on the four safety checks above:
//:
//: **Phase 1**
//: - A designated or convenience initializer is called on a class.
//: - Memory for a new instance of that class is allocated. The memory is not yet initialized.
//: - A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
//: - The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
//: - This continues up the class inheritance chain until the top of the chain is reached.
//: - Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
//:
//: **Phase 2**
//: - Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access `self` and can modify its properties, call its instance methods, and so on.
//: - Finally, any convenience initializers in the chain have the option to customize the instance and to work with `self`.
//:
//: \
//: Here’s how phase 1 looks for an initialization call for a hypothetical subclass and superclass:
//:
//: ![Initialization Phase 2](twoPhaseInitialization01_2x.png)
//:
//: \
//: Here’s how phase 2 looks for the same initialization call:
//:
//: ![Initialization Phase 2](twoPhaseInitialization02_2x.png)
//:
//: ### Initializer Inheritance and Overriding
//: Unlike subclasses in Objective-C, Swift subclasses do not inherit their superclass initializers by default.
//:
//: Swift’s approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to create a new instance of the subclass that is not fully or correctly initialized.
/*:
 - Note:
Superclass initializers are inherited in certain circumstances, but only when it is safe and appropriate to do so.
 */
//: When you write a subclass initializer that matches a superclass _designated_ initializer, you are effectively providing an override of that designated initializer.
//:
//: Therefore, you must write the `override` modifier before the subclass’s initializer definition.
//:
//: This is true even if you are overriding an automatically provided default initializer.
//:
/*:
 - Note:
You always write the `override` modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer.
 */
//: if you write a subclass initializer that matches a superclass _convenience_ initializer, that superclass convenience initializer can never be called directly by your subclass.
//:
//: Therefore, your subclass is not (strictly speaking) providing an override of the superclass initializer. As a result, you do not write the `override` modifier when providing a matching implementation of a superclass convenience initializer.
//:
//: The example below defines a base class called `Vehicle`:
    class Vehicle {
        var numberOfWheels = 0
        
        var description: String {
            return "\(numberOfWheels) wheel(s)"
        }
    }
//: It does not provide any custom initializer itself, thus it automatically receives a default initializer:
    let vehicle = Vehicle()

    print("Vehicle: \(vehicle.description)")
//: The next example defines a subclass of `Vehicle` called `Bicycle`:
    class Bicycle: Vehicle {
        override init() {
            super.init()
            numberOfWheels = 2
        }
    }

    let bicycle = Bicycle()

    print("Bicycle: \(bicycle.description)")
//: If a subclass initializer performs no customization in phase 2 of the initialization process, and the superclass has a zero-argument designated initializer, you can omit a call to `super.init()` after assigning values to all of the subclass’s stored properties:
    class Hoverboard: Vehicle {
        var color: String
        
        init(color: String) {
            self.color = color
            // super.init() implicitly called here
        }
        
        override var description: String {
            return "\(super.description) in a beautiful \(color)"
        }
    }

    let hoverboard = Hoverboard(color: "silver")

    print("Hoverboard: \(hoverboard.description)")
/*:
 - Note:
Subclasses can modify inherited variable properties during initialization, but can not modify inherited constant properties.
 */
//: ### Automatic Initializer Inheritance
//: By default, subclasses do not inherit their superclass initializers. However, superclass initializers are automatically inherited if certain conditions are met.
//:
//: If you provide _default values_ for any _new properties_ you introduce in a subclass, the following two rules apply:
//:
//: **Rule 1**
//: - If your subclass doesn’t define any designated initializers, it automatically inherits all of its superclass designated initializers.
//:
//: **Rule 2**
//: - If your subclass provides an implementation of all of its superclass designated initializers—either by inheriting them as per rule 1, or by providing a custom implementation as part of its definition—then it automatically inherits all of the superclass _convenience initializers_.
//:
//: These rules apply even if your subclass adds further convenience initializers.
/*:
 - Note:
A subclass can implement a superclass designated initializer as a subclass convenience initializer as part of satisfying rule 2.
 */
//: ### Designated and Convenience Initializers in Action
//: The following example shows designated initializers, convenience initializers, and automatic initializer inheritance in action.
//:
//: The `Food` class:
    class Food {
        var name: String
        
        init(name: String) {
            self.name = name
        }
        
        convenience init() {
            self.init(name: "[Unnamed]")
        }
    }
//: _The initializer chain for the `Food` class:_
//:
//: ![Initializers Example 1](initializersExample01_2x.png "`Food` Initializer Chain")
//:

    let namedMeat = Food(name: "Bacon")

    let mysteryMeat = Food()
//: Classes do not have a default memberwise initializer, and so the `Food` class provides a designated initializer that takes a single argument called `name`.
//:
//: The `init(name: String)` initializer from the `Food` class is provided as a designated initializer, because it ensures that all stored properties of a new `Food` instance are fully initialized.
//:
//: The `Food` class does not have a superclass, and so the `init(name: String)` initializer does not need to call `super.init()` to complete its initialization.
//:
//: The `Food` class also provides a _convenience_ initializer, `init()`, with no arguments.
//:
//: The `RecipeIngredient` subclass of `Food`:
    class RecipeIngredient: Food {
        var quantity: Int
        
        init(name: String, quantity: Int) {
            self.quantity = quantity
            super.init(name: name)
        }
        
        override convenience init(name: String) {
            self.init(name: name, quantity: 1)
        }
    }
//: _The initializer chain for the `RecipeIngredient` class:_
//:
//: ![Initializers Example 2](initializersExample02_2x.png "`RecipeIngredient` Initializer Chain")
//:
    let oneMysteryItem = RecipeIngredient()

    let oneBacon = RecipeIngredient(name: "Bacon")

    let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
//: The `ShoppingListItem` subclass of `RecipeIngredient`:
    class ShoppingListItem: RecipeIngredient {
        var purchased = false
        
        var description: String {
            var output = "\(quantity) x \(name)"
            output += purchased ? " ✔" : " ✘"
            return output
        }
    }
/*:
 - Note:
`ShoppingListItem` does not define an initializer to provide an initial value for purchased, because items in a shopping list (as modeled here) always start out unpurchased.
 */
//: _The overall initializer chain for all three classes:_
//:
//: ![Initializers Example 3](initializersExample03_2x.png "Initializer chain")
//:
    var breakfastList = [
        ShoppingListItem(),
        ShoppingListItem(name: "Bacon"),
        ShoppingListItem(name: "Eggs", quantity: 6),
    ]

    breakfastList[0].name = "Orange juice"

    breakfastList[0].purchased = true

    for item in breakfastList {
        print(item.description)
    }
//:
//: ## Failable Initializers
//: It is sometimes useful to define a class, structure, or enumeration for which initialization can fail.
//:
//: This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.
//:
//: You write a failable initializer by placing a question mark after the `init` keyword (`init?`).
/*:
 - Note:
 You cannot define a failable and a nonfailable initializer with the same parameter types and names.
 */
//: A failable initializer creates an _optional_ value of the type it initializes.
//:
//: You write `return nil` within a failable initializer to indicate a point at which initialization failure can be triggered.
/*:
 - Note:
 Strictly speaking, initializers do not return a value. Rather, their role is to ensure that `self` is fully and correctly initialized by the time that initialization ends. \
 Although you write `return nil` to trigger an initialization failure, you do not use the `return` keyword to indicate initialization success.
 */
//: For instance, failable initializers are implemented for numeric type conversions.
    let wholeNumber: Double = 12345.0
    let pi = 3.14159

    if let valueMaintained = Int(exactly: wholeNumber) {
        print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
    }

    let valueChanged = Int(exactly: pi)

    if valueChanged == nil {
        print("\(pi) conversion to Int does not maintain value")
    }
//:
    struct Animal {
        let species: String
        
        init?(species: String) {
            if species.isEmpty { return nil }
            self.species = species
        }
    }

    let someCreature = Animal(species: "Giraffe")

    if let giraffe = someCreature {
        print("An animal was initialized with a species of \(giraffe.species)")
    }

    let anonymousCreature = Animal(species: "")

    if anonymousCreature == nil {
        print("The anonymous creature could not be initialized")
    }

/*:
 - Note:
 Checking for an empty string value (such as `""` rather than `"Giraffe"`) is not the same as checking for `nil` to indicate the absence of an _optional_ `String` value. In the example above, an empty string (`""`) is a valid, non-optional `String`. However, it is not appropriate for an animal to have an empty string as the value of its `species` property. To model this restriction, the failable initializer triggers an initialization failure if an empty string is found.
 */
//: ### Failable Initializers for Enumerations
    enum TemperatureUnitVariant {
        case kelvin, celsius, fahrenheit
        init?(symbol: Character) {
            switch symbol {
            case "K":
                self = .kelvin
            case "C":
                self = .celsius
            case "F":
                self = .fahrenheit
            default:
                return nil
            }
        }
    }
//:
    let fahrenheitUnit = TemperatureUnitVariant(symbol: "F")

    if fahrenheitUnit != nil {
        print("This is a defined temperature unit, so initialization succeeded.")
    }

    let unknownUnit = TemperatureUnitVariant(symbol: "X")

    if unknownUnit == nil {
        print("This is not a defined temperature unit, so initialization failed.")
    }
//: Failable Initializers for Enumerations with Raw Values
//: Enumerations with raw values automatically receive a failable initializer, `init?(rawValue:)`:
    enum TemperatureUnit: Character {
        case kelvin = "K", celsius = "C", fahrenheit = "F"
    }

    let fahrenheitTempUnit = TemperatureUnit(rawValue: "F")
    if fahrenheitTempUnit != nil {
        print("This is a defined temperature unit, so initialization succeeded.")
    }
    // Prints "This is a defined temperature unit, so initialization succeeded."

    let unknownTempUnit = TemperatureUnit(rawValue: "X")
    if unknownTempUnit == nil {
        print("This is not a defined temperature unit, so initialization failed.")
    }
//:
//: ### Propagation of Initialization Failure
//: A failable initializer of a class, structure, or enumeration can delegate across to another failable initializer from the same class, structure, or enumeration. Similarly, a subclass failable initializer can delegate up to a superclass failable initializer.
/*:
 - Note:
A failable initializer can also delegate to a nonfailable initializer. \
Use this approach if you need to add a potential failure state to an existing initialization process that does not otherwise fail.
 */
    class Product {
        let name: String
        
        init?(name: String) {
            if name.isEmpty { return nil }
            self.name = name
        }
    }

    class CartItem: Product {
        let quantity: Int
        
        init?(name: String, quantity: Int) {
            if quantity < 1 { return nil }
            self.quantity = quantity
            super.init(name: name)
        }
    }
//: If you create a `CartItem` instance with a nonempty name and a `quantity` of `1` or more, initialization succeeds:
    if let twoSocks = CartItem(name: "sock", quantity: 2) {
        print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
    }
//: If you try to create a `CartItem` instance with a `quantity` value of `0`, the `CartItem` initializer causes initialization to fail:
    if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
        print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
    } else {
        print("Unable to initialize zero shirts")
    }
//: Similarly, if you try to create a `CartItem` instance with an empty `name` value, the superclass `Product` initializer causes initialization to fail:
    if let oneUnnamed = CartItem(name: "", quantity: 1) {
        print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
    } else {
        print("Unable to initialize one unnamed product")
    }
//: ### Overriding a Failable Initializer
//: You can override a superclass failable initializer in a subclass, just like any other initializer.
//:
//: Alternatively, you can override a superclass failable initializer with a subclass _nonfailable_ initializer.
/*:
 - Note:
 You can override a failable initializer with a nonfailable initializer but not the other way around.
 */
    class Document {
        var name: String?
        // this initializer creates a document with a nil name value
        init() {}
        
        // this initializer creates a document with a nonempty name value
        init?(name: String) {
            if name.isEmpty { return nil }
            self.name = name
        }
    }
//:
    class AutomaticallyNamedDocument: Document {
        override init() {
            super.init()
            self.name = "[Untitled]"
        }
        
        override init(name: String) {
            super.init()
            if name.isEmpty {
                self.name = "[Untitled]"
            } else {
                self.name = name
            }
        }
    }
//:
    class UntitledDocument: Document {
        override init() {
            super.init(name: "[Untitled]")!
        }
    }
//: ### The init! Failable Initializer
//: Alternatively, you can define a failable initializer that creates an _implicitly unwrapped_ optional instance of the appropriate type.
//: Do this by placing an exclamation mark after the init keyword (`init!`) instead of a question mark.
//:
//: You can delegate from `init?` to `init!` and vice versa, and you can override `init?` with `init!` and vice versa.
//:
//: You can also delegate from init to `init!`, although doing so will trigger an assertion if the `init!` initializer causes initialization to fail.
//:
//: ## Required Initializers
//: Write the `required` modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:
    class SomeClass {
        required init() {
            // initializer implementation goes here
        }
    }
//: You must also write the `required` modifier before every subclass implementation of a required initializer, to indicate that the initializer requirement applies to further subclasses in the chain.
//:
//: You do not write the `override` modifier when overriding a required designated initializer:
    class SomeSubclass: SomeClass {
        required init() {
            // subclass implementation of the required initializer goes here
        }
    }
/*:
 - Note:
 You do not have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer.
 */
//: ## Setting a Default Property Value with a Closure or Function
//: If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property.
//:
//: These kinds of closures or functions typically create a temporary value of the same type as the property, tailor that value to represent the desired initial state, and then return that temporary value to be used as the property’s default value.
/*:
 - Example:
 ```
class SomeClass {
    let someProperty: SomeType = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return someValue
    }()
 }
 ```
 */
//: Note that the closure’s end curly brace is followed by an empty pair of parentheses. This tells Swift to execute the closure immediately. If you omit these parentheses, you are trying to assign the closure itself to the property, and not the return value of the closure.
/*:
 - Note:
 If you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit `self` property, or call any of the instance’s methods.
 */
//:
//: An example `Chessboard` structure :
//:
//: ![Chessboard](chessBoard_2x.png)
//:
    struct Chessboard {
        let boardColors: [Bool] = {
            var temporaryBoard = [Bool]()
            var isBlack = false
            for i in 1...8 {
                for j in 1...8 {
                    temporaryBoard.append(isBlack)
                    isBlack = !isBlack
                }
                isBlack = !isBlack
            }
            return temporaryBoard
        }()
        
        func squareIsBlackAt(row: Int, column: Int) -> Bool {
            return boardColors[(row * 8) + column]
        }
    }

    let board = Chessboard()

    print(board.squareIsBlackAt(row: 0, column: 1))

    print(board.squareIsBlackAt(row: 7, column: 7))
//:
//:
//: [Next →](@next)
