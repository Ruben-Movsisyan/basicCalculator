//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//: # Automatic Reference Counting
//: Swift uses _Automatic Reference Counting_ (ARC) to track and manage your app’s memory usage. \
//: In most cases, this means that memory management “just works” in Swift, and you do not need to think about memory management yourself. \
//: ARC automatically frees up the memory used by class instances when those instances are no longer needed.
//:
//: However, in a few cases ARC requires more information about the relationships between parts of your code in order to manage memory for you.
//:
//: Reference counting applies only to instances of classes. \
//: Structures and enumerations are value types, not reference types, and are not stored and passed by reference.
//: ## How ARC Works
//: Every time you create a new instance of a class, ARC allocates a chunk of memory to store information about that instance. \
//: When an instance is no longer needed, ARC frees up the memory used by that instance so that the memory can be used for other purposes instead.
//: However, if ARC were to deallocate an instance that was still in use, it would no longer be possible to access that instance’s properties, or call that instance’s methods. Indeed, if you tried to access the instance, your app would most likely crash.
//:
//: To make sure that instances don’t disappear while they are still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not deallocate an instance as long as at least one active reference to that instance still exists. \
//: To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a _strong reference_ to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and does not allow it to be deallocated for as long as that strong reference remains.
//: ## ARC in Action
//: Here’s an example of how Automatic Reference Counting works:
//:
//: _In this page `ExampleX` structs used solely to provide namespaces in order to avoid name collisions._
struct Example1 {
    class Person {
        let name: String
        
        init(name: String) {
            self.name = name
            print("Example1: \(name) is being initialized")
        }
        
        deinit {
            print("Example1: \(name) is being deinitialized")
        }
    }
}

    var reference1: Example1.Person?

    var reference2: Example1.Person?

    var reference3: Example1.Person?

    reference1 = Example1.Person(name: "John Appleseed")
//: Because the new `Person` instance has been assigned to the `reference1` variable, there is now a _strong reference_ from `reference1` to the new `Person` instance. \
//: Because there is at least one strong reference, ARC makes sure that this `Person` is kept in memory and is not deallocated.
//:
//: If you assign the same `Person` instance to two more variables, two more strong references to that instance are established:
    reference2 = reference1

    reference3 = reference1
//: There are now _three_ strong references to this single `Person` instance.
//:
//: If you break two of these strong references (including the original reference) by assigning `nil` to two of the variables, a single strong reference remains, and the `Person` instance is not deallocated:
    reference1 = nil

    reference2 = nil
//: ARC does not deallocate the `Person` instance until the third and final strong reference is broken, at which point it’s clear that you are no longer using the `Person` instance:
    reference3 = nil
//: ## Strong Reference Cycles Between Class Instances
//: It’s possible to write code in which an instance of a class _never_ gets to a point where it has zero strong references. \
//: This can happen if two class instances hold a strong reference to each other, such that each instance keeps the other alive. This is known as a _strong reference cycle_. \
//: You resolve strong reference cycles by defining some of the relationships between classes as _weak_ or _unowned_ references instead of as _strong_ references.
//:
//: Here’s an example of how a strong reference cycle can be created by accident:
struct Example2 {
    class Person {
        let name: String

        init(name: String) { self.name = name }

        var apartment: Apartment?

        deinit { print("Example2: \(name) is being deinitialized") }
    }

    class Apartment {
        let unit: String
        
        init(unit: String) { self.unit = unit }
        
        var tenant: Person?
        
        deinit { print("Example2: Apartment \(unit) is being deinitialized") }
    }
}

//: Both of these variables have an initial value of `nil`, by virtue of being optional:
    var johnExample2: Example2.Person?

    var unit4AExample2: Example2.Apartment?
//: You can now create a specific `Person` instance and `Apartment` instance and assign these new instances to the `john` and `unit4A` variables:
    johnExample2 = Example2.Person(name: "John Appleseed")

    unit4AExample2 = Example2.Apartment(unit: "4A")
//: Here’s how the strong references look after creating and assigning these two instances:
//:
//: ![reference-cycle-1](referenceCycle01_2x.png)
//:
//: You can now link the two instances together so that the person has an apartment, and the apartment has a tenant:
    johnExample2!.apartment = unit4AExample2

    unit4AExample2!.tenant = johnExample2
//: Here’s how the strong references look after you link the two instances together:
//:
//: ![reference-cycle-2](referenceCycle02_2x.png)
//:
//: Linking these two instances creates a strong reference cycle between them.
//: Therefore, when you break the strong references, the reference counts do not drop to zero, and the instances are not deallocated by ARC:
    johnExample2 = nil

    unit4AExample2 = nil
//: Note that neither deinitializer was called when you set these two variables to `nil`. The strong reference cycle prevents the `Person` and `Apartment` instances from ever being deallocated, causing a memory leak in your app.
//:
//: ![reference-cycle-3](referenceCycle03_2x.png)
//:
//: The strong references between the `Person` instance and the `Apartment` instance remain and cannot be broken.
//: ## Resolving Strong Reference Cycles Between Class Instances
//: Swift provides two ways to resolve strong reference cycles when you work with properties of class type: _weak references_ and _unowned references_.
//:
//: Weak and unowned references enable one instance in a reference cycle to refer to the other instance _without_ keeping a strong hold on it. The instances can then refer to each other without creating a strong reference cycle.
//:
//: Use a weak reference when the other instance has a shorter lifetime—that is, when the other instance can be deallocated first. \
//: In the `Apartment` example above, it’s appropriate for an apartment to be able to have no tenant at some point in its lifetime, and so a weak reference is an appropriate way to break the reference cycle in this case.
//:
//: In contrast, use an unowned reference when the other instance has the same lifetime or a longer lifetime.
//: ### Weak References
//: A _weak reference_ is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance. \
//: This behavior prevents the reference from becoming part of a strong reference cycle. \
//: You indicate a weak reference by placing the `weak` keyword before a property or variable declaration. \
//: Because a weak reference does not keep a strong hold on the instance it refers to, it’s possible for that instance to be deallocated while the weak reference is still referring to it. \
//: Therefore, ARC automatically sets a weak reference to `nil` when the instance that it refers to is deallocated. \
//: And, because weak references need to allow their value to be changed to `nil` at runtime, they are always declared as variables, rather than constants, of an optional type. \
//: You can check for the existence of a value in the weak reference, just like any other optional value, and you will never end up with a reference to an invalid instance that no longer exists.
/*:
 - Note:
 Property observers aren’t called when ARC sets a weak reference to `nil`.
 */
struct Example3 {
    class Person {
        let name: String
        
        init(name: String) { self.name = name }
        
        var apartment: Apartment?
        
        deinit { print("Example3: \(name) is being deinitialized") }
    }

    class Apartment {
        let unit: String
        
        init(unit: String) { self.unit = unit }
        
        weak var tenant: Person?
        
        deinit { print("Example3: Apartment \(unit) is being deinitialized") }
    }
}

    var johnExample3: Example3.Person?
    var unit4AExample3: Example3.Apartment?

    johnExample3 = Example3.Person(name: "John Appleseed")
    unit4AExample3 = Example3.Apartment(unit: "4A")

    johnExample3!.apartment = unit4AExample3
    unit4AExample3!.tenant = johnExample3
//:
//: ![weak-reference-1](weakReference01_2x.png)
//:
//: You break the strong reference held by the `john` variable by setting it to `nil`, there are no more strong references to the `Person` instance:
    johnExample3 = nil
//: Because there are no more strong references to the `Person` instance, it’s deallocated and the tenant property is set to `nil`:
//:
//: ![weak-reference-2](weakReference02_2x.png)
//:
//: The only remaining strong reference to the `Apartment` instance is from the `unit4A` variable:
    unit4AExample3 = nil
//: Because there are no more strong references to the `Apartment` instance, it too is deallocated:
//:
//: ![weak-reference-3](weakReference03_2x.png)
//:
/*:
 - Note:
 In systems that use garbage collection, weak pointers are sometimes used to implement a simple caching mechanism because objects with no strong references are deallocated only when memory pressure triggers garbage collection. However, with ARC, values are deallocated as soon as their last strong reference is removed, making weak references unsuitable for such a purpose.
 */
//: ### Unowned References
//: Like a weak reference, an _unowned reference_ does not keep a strong hold on the instance it refers to. \
//: Unlike a weak reference, however, an unowned reference is used when the other instance has the same lifetime  or a longer lifetime. \
//: You indicate an unowned reference by placing the `unowned` keyword before a property or variable declaration.
//:
//: An unowned reference is expected to always have a value. As a result, ARC never sets an unowned reference’s value to `nil`, which means that unowned references are defined using non-optional types.
/*:
 - Note:
 Use an unowned reference only when you are sure that the reference _always_ refers to an instance that has not been deallocated.
If you try to access the value of an unowned reference after that instance has been deallocated, you’ll get a runtime error.
 */
//: In this data model, a customer may or may not have a credit card, but a credit card will _always_ be associated with a customer. \
//: A `CreditCard` instance never outlives the `Customer` that it refers to. To represent this, the `Customer` class has an optional `card` property, but the `CreditCard` class has an unowned (and non-optional) `customer` property:
    class Customer {
        let name: String
        var card: CreditCard?
        
        init(name: String) {
            self.name = name
        }
        
        deinit { print("\(name) is being deinitialized") }
    }

    class CreditCard {
        let number: UInt64
        unowned let customer: Customer
        
        init(number: UInt64, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        
        deinit { print("Card #\(number) is being deinitialized") }
    }
/*:
 - Note:
 The number property of the `CreditCard` class is defined with a type of `UInt64` rather than `Int`, to ensure that the `number` property’s capacity is large enough to store a 16-digit card number on both 32-bit and 64-bit systems.
 */
    var john: Customer?

    john = Customer(name: "John Appleseed")

    john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
//: Here’s how the references look, now that you’ve linked the two instances:
//:
//: ![unowned-reference-1](unownedReference01_2x.png)
//:
//: The `Customer` instance now has a strong reference to the `CreditCard` instance, and the `CreditCard` instance has an unowned reference to the `Customer` instance.
//:
//: Because of the unowned customer reference, when you break the strong reference held by the `john` variable, there are no more strong references to the `Customer` instance:
//:
//: ![unowned-reference-2](unownedReference02_2x.png)
//:
//: Because there are no more strong references to the `Customer` instance, it’s deallocated. After this happens, there are no more strong references to the `CreditCard` instance, and it too is deallocated:
    john = nil
/*:
 - Note:
 The examples above show how to use _safe_ unowned references. Swift also provides _unsafe_ unowned references for cases where you need to disable runtime safety checks—for example, for performance reasons. As with all unsafe operations, you take on the responsibility for checking that code for safety. \
You indicate an unsafe unowned reference by writing `unowned(unsafe)`. If you try to access an unsafe unowned reference after the instance that it refers to is deallocated, your program will try to access the memory location where the instance used to be, which is an unsafe operation.
 */
//: ### Unowned References and Implicitly Unwrapped Optional Properties
//: The examples for weak and unowned references above cover two of the more common scenarios in which it’s necessary to break a strong reference cycle. \
//: There is a third scenario, in which _both_ properties should always have a value, and neither property should ever be _nil_ once initialization is complete. In this scenario, it’s useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class. \
//: This enables both properties to be accessed directly (without optional unwrapping) once initialization is complete, while still avoiding a reference cycle. This section shows you how to set up such a relationship:
    class Country {
        let name: String
        var capitalCity: City!
        
        init(name: String, capitalName: String) {
            self.name = name
            self.capitalCity = City(name: capitalName, country: self)
        }
    }

    class City {
        let name: String
        unowned let country: Country
        
        init(name: String, country: Country) {
            self.name = name
            self.country = country
        }
    }

    var country = Country(name: "Canada", capitalName: "Ottawa")

    print("\(country.name)'s capital city is called \(country.capitalCity.name)")
//: ## Strong Reference Cycles for Closures
//: A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance. \
//: This capture might occur because the closure’s body accesses a property of the instance, such as `self.someProperty`, or because the closure calls a method on the instance, such as `self.someMethod()`. In either case, these accesses cause the closure to “capture” `self`, creating a strong reference cycle. \
//: This strong reference cycle occurs because closures, like classes, are _reference types_. When you assign a closure to a property, you are assigning a _reference_ to that closure. \
//: In essence, it’s the same problem as above—two strong references are keeping each other alive. However, rather than two class instances, this time it’s a class instance and a closure that are keeping each other alive. \
//: Swift provides an elegant solution to this problem, known as a _closure capture list_. \
//: The example below shows how you can create a strong reference cycle when using a closure that references `self`:
struct Example4 {
    class HTMLElement {
        let name: String
        let text: String?
        
        lazy var asHTML: () -> String = {
            if let text = self.text {
                return "<\(self.name)>\(text)</\(self.name)>"
            } else {
                return "<\(self.name) />"
            }
        }
        
        init(name: String, text: String? = nil) {
            self.name = name
            self.text = text
        }
        
        deinit {
            print("\(name) is being deinitialized")
        }
    }
}

    let heading = Example4.HTMLElement(name: "h1")

    let defaultText = "some default text"

    heading.asHTML = {
        return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
    }

    print(heading.asHTML())
/*:
 - Note:
 The `asHTML` property is declared as a lazy property, because it’s only needed if and when the element actually needs to be rendered as a string value for some HTML output target. The fact that `asHTML` is a lazy property means that you can refer to `self` within the default closure, because the lazy property will not be accessed until after initialization has been completed and `self` is known to exist.
 */
    var paragraphExample1: Example4.HTMLElement? = Example4.HTMLElement(name: "p", text: "hello, world")

    print(paragraphExample1!.asHTML())
/*:
 - Note:
 The `paragraph` variable above is defined as an _optional_ `HTMLElement`, so that it can be set to `nil` below to demonstrate the presence of a strong reference cycle.
 */
//: Unfortunately, the `HTMLElement` class, as written above, creates a strong reference cycle between an `HTMLElement` instance and the closure used for its default `asHTML` value. Here’s how the cycle looks:
//:
//: ![closure-reference-1](closureReferenceCycle01_2x.png)
//:
//: The instance’s `asHTML` property holds a strong reference to its closure. However, because the closure refers to `self` within its body (as a way to reference `self.name` and `self.text`), the closure _captures_ `self`, which means that it holds a strong reference back to the `HTMLElement` instance.
/*:
 - Note:
 Even though the closure refers to `self` multiple times, it only captures one strong reference to the `HTMLElement` instance.
 */
//: If you set the paragraph variable to `nil` and break its strong reference to the `HTMLElement` instance, neither the `HTMLElement` instance nor its closure are deallocated, because of the strong reference cycle:
    paragraphExample1 = nil
//: ## Resolving Strong Reference Cycles for Closures
//: You resolve a strong reference cycle between a closure and a class instance by defining a _capture_ list as part of the closure’s definition. \
//: A capture list defines the rules to use when capturing one or more reference types within the closure’s body. \
//: As with strong reference cycles between two class instances, you declare each captured reference to be a weak or unowned reference rather than a strong reference. \
//: The appropriate choice of weak or unowned depends on the relationships between the different parts of your code.
/*:
 - Note:
 Swift requires you to write `self.someProperty` or `self.someMethod()` (rather than just `someProperty` or `someMethod()`) whenever you refer to a member of `self` within a closure. This helps you remember that it’s possible to capture `self` by accident.
 */
//: ### Defining a Capture List
//: Each item in a capture list is a pairing of the weak or unowned keyword with a reference to a class instance (such as self) or a variable initialized with some value (such as delegate = self.delegate!).
//: These pairings are written within a pair of square braces, separated by commas.
//: Place the capture list before a closure’s parameter list and return type if they are provided:
/*:
 - Example:
 ```
 lazy var someClosure: (Int, String) -> String = {
 [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
    // closure body goes here
 }
 ```
 */
//: If a closure does not specify a parameter list or return type because they can be inferred from context, place the capture list at the very start of the closure, followed by the `in` keyword:
/*:
 - Example:
 ```
 lazy var someClosure: () -> String = {
 [unowned self, weak delegate = self.delegate!] in
    // closure body goes here
 }
 ```
 */
//: ### Weak and Unowned References
//: Define a capture in a closure as an unowned reference when the closure and the instance it captures will always refer to each other, and will always be deallocated at the same time.
//:
//: Conversely, define a capture as a weak reference when the captured reference may become `nil` at some point in the future. \
//: Weak references are always of an optional type, and automatically become `nil` when the instance they reference is deallocated. This enables you to check for their existence within the closure’s body.
/*:
 - Note:
 If the captured reference will never become `nil`, it should always be captured as an unowned reference, rather than a weak reference.
 */
//: Here’s how you write the `HTMLElement` class to avoid the cycle:
    class HTMLElement {
        let name: String
        let text: String?
        
        lazy var asHTML: () -> String = {
            [unowned self] in
            if let text = self.text {
                return "<\(self.name)>\(text)</\(self.name)>"
            } else {
                return "<\(self.name) />"
            }
        }
        
        init(name: String, text: String? = nil) {
            self.name = name
            self.text = text
        }
        
        deinit {
            print("\(name) is being deinitialized")
        }
    }

    var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")

    print(paragraph!.asHTML())
//: Here’s how the references look with the capture list in place:
//:
//: ![closure-reference-2](closureReferenceCycle02_2x.png)
//:
//: This time, the capture of `self` by the closure is an unowned reference, and does not keep a strong hold on the `HTMLElement` instance it has captured. If you set the strong reference from the paragraph variable to `nil`, the `HTMLElement` instance is deallocated, as can be seen from the printing of its deinitializer message in the example below:
    paragraph = nil
//:
//: [Next →](@next)
