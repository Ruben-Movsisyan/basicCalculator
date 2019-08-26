//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//: # Generics
//: Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define.
//: You can write code that avoids duplication and expresses its intent in a clear, abstracted manner. \
//: Much of the Swift standard library is built with generic code.
//: For example, Swift’s `Array` and `Dictionary` types are both generic collections.
//: You can create an array that holds `Int` values, or an array that holds `String` values, or indeed an array for any other type that can be created in Swift.
//: ## The Problem That Generics Solve
//: Here’s a standard, nongeneric function called `swapTwoInts(_:_:)`, which swaps two `Int` values:
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
//: This function makes use of in-out parameters to swap the values of `a` and `b`. \
//: The `swapTwoInts(_:_:)` function swaps the original value of `b` into `a`, and the original value of `a` into `b`. You can call this function to swap the values in two `Int` variables:
    var someInt = 3
    var anotherInt = 107

    swapTwoInts(&someInt, &anotherInt)

    print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//: The `swapTwoInts(_:_:)` function is useful, but it can only be used with `Int` values.
//: If you want to swap two `String` values, or two `Double` values, you have to write more functions, such as the `swapTwoStrings(_:_:)` and `swapTwoDoubles(_:_:)` functions shown below:
    func swapTwoStrings(_ a: inout String, _ b: inout String) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

    func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
//: You may have noticed that the bodies of the `swapTwoInts(_:_:)`, `swapTwoStrings(_:_:)`, and `swapTwoDoubles(_:_:)` functions are identical. The only difference is the type of the values that they accept (`Int`, `String`, and `Double`).
//:
//: It’s more useful, and considerably more flexible, to write a single function that swaps two values of _any_ type.
//:
//: Generic code enables you to write such a function. (A generic version of these functions is defined below.)
/*:
 - Note:
 In all three functions, the types of `a` and `b` must be the same. If `a` and `b` aren’t of the same type, it isn’t possible to swap their values. Swift is a type-safe language, and doesn’t allow (for example) a variable of type `String` and a variable of type `Double` to swap values with each other. Attempting to do so results in a compile-time error.
 */
//: ## Generic Functions
//: _Generic functions_ can work with any type. \
//: Here’s a generic version of the `swapTwoInts(_:_:)` function from above, called `swapTwoValues(_:_:)`:
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
//: The generic version of the function uses a _placeholder_ type name (called `T`, in this case) instead of an _actual_ type name (such as `Int`, `String`, or `Double`). \
//: The placeholder type name doesn’t say anything about what `T` must be, but it does say that both `a` and `b` must be of the same type `T`, whatever `T` represents. \
//: The actual type to use in place of `T` is determined each time the `swapTwoValues(_:_:)` function is called.
//:
//: The other difference between a generic function and a nongeneric function is that the generic function’s name (`swapTwoValues(_:_:)`) is followed by the placeholder type name (`T`) inside angle brackets (`<T>`). \
//: The brackets tell Swift that `T` is a placeholder type name within the `swapTwoValues(_:_:)` function definition. Because `T` is a placeholder, Swift doesn’t look for an actual type called `T`.
//:
//: Each time `swapTwoValues(_:_:)` is called, the type to use for `T` is inferred from the types of values passed to the function.
//: In the two examples below, `T` is inferred to be `Int` and `String` respectively:
    swapTwoValues(&someInt, &anotherInt)

    var someString = "hello"
    var anotherString = "world"

    swapTwoValues(&someString, &anotherString)
/*:
 - Note:
The `swapTwoValues(_:_:)` function defined above is inspired by a generic function called `swap`, which is part of the Swift standard library, and is automatically made available for you to use in your apps. \
If you need the behavior of the `swapTwoValues(_:_:)` function in your own code, you can use Swift’s existing `swap(_:_:)` function rather than providing your own implementation.
 */
//: ## Type Parameters
//: In the `swapTwoValues(_:_:)` example above, the placeholder type `T` is an example of a _type parameter_. \
//: Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as `<T>`).
//:
//: Once you specify a type parameter, you can use it to define the type of a function’s parameters (such as the `a` and `b` parameters of the `swapTwoValues(_:_:)` function), or as the function’s return type, or as a type annotation within the body of the function. \
//: In each case, the type parameter is replaced with an actual type whenever the function is called. (In the `swapTwoValues(_:_:)` example above, `T` was replaced with `Int` the first time the function was called, and was replaced with `String` the second time it was called.)
//:
//: You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.
//: ## Naming Type Parameters
//: In most cases, type parameters have descriptive names, such as `Key` and `Value` in `Dictionary<Key, Value>` and `Element` in `Array<Element>`, which tells the reader about the relationship between the type parameter and the generic type or function it’s used in.
//:
//: When there isn’t a meaningful relationship between them, it’s traditional to name them using single letters such as `T`, `U`, and `V`.
/*:
 - Note:
 Always give type parameters upper camel case names (such as `T` and `MyTypeParameter`) to indicate that they’re a placeholder for a _type_, not a value.
 */
//: ## Generic Types
//: In addition to generic functions, Swift enables you to define your own _generic types_.
//: These are custom classes, structures, and enumerations that can work with any type, in a similar way to `Array` and `Dictionary`.
//: This section shows you how to write a generic collection type called `Stack`. \
//: A stack is an ordered set of values, similar to an array, but with a more restricted set of operations than Swift’s `Array` type. \
//: An array allows new items to be inserted and removed at any location in the array. A stack, however, allows new items to be appended only to the end of the collection (known as _pushing_ a new value on to the stack). \
//: Similarly, a stack allows items to be removed only from the end of the collection (known as _popping_ a value off the stack).
/*:
 - Note:
 The concept of a stack is used by the `UINavigationController` class to model the view controllers in its navigation hierarchy. You call the `UINavigationController` class `pushViewController(_:animated:)` method to add (or push) a view controller on to the navigation stack, and its `popViewControllerAnimated(_:)` method to remove (or pop) a view controller from the navigation stack. \
A stack is a useful collection model whenever you need a strict “last in, first out” approach to managing a collection.
 */
//: The illustration below shows the push and pop behavior for a stack:
//:
//: ![Stack](stackPushPop_2x.png "A stack")
//:
//: 1. There are currently three values on the stack.
//: 2. A fourth value is pushed onto the top of the stack.
//: 3. The stack now holds four values, with the most recent one at the top.
//: 4. The top item in the stack is popped.
//: 5. After popping a value, the stack once again holds three values.
//:
//: Here’s how to write a nongeneric version of a stack, in this case for a stack of `Int` values:
    struct IntStackVar1 {
        var items = [Int]()
        
        mutating func push(_ item: Int) {
            items.append(item)
        }
        
        mutating func pop() -> Int {
            return items.removeLast()
        }
    }
//: The `IntStack` type shown above can only be used with `Int` values, however. It would be much more useful to define a _generic_ `Stack` class, that can manage a stack of _any_ type of value.
//: Here’s a generic version of the same code:
    struct StackVar1<Element> {
        var items = [Element]()
        
        mutating func push(_ item: Element) {
            items.append(item)
        }
        
        mutating func pop() -> Element {
            return items.removeLast()
        }
    }
//: Because it’s a generic type, `Stack` can be used to create a stack of _any_ valid type in Swift, in a similar manner to `Array` and `Dictionary`:
    var stackOfStrings = StackVar1<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    stackOfStrings.push("cuatro")
//: Here’s how `stackOfStrings` looks after pushing these four values on to the stack:
//:
//: ![StackOfStrings](stackPushedFourStrings_2x.png "Stack of Strings")
//:
//: Popping a value from the stack removes and returns the top value, `"cuatro"`:
    let fromTheTop = stackOfStrings.pop()
//: Here’s how the stack looks after popping its top value:
//:
//: ![StackPopped](stackPoppedOneString_2x.png "Popped one String")
//:
//: ## Extending a Generic Type
//: When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition. \
//: Instead, the type parameter list from the _original_ type definition is available within the body of the extension, and the original type parameter names are used to refer to the type parameters from the original definition.
    extension StackVar1 {
        var topItem: Element? {
            return items.isEmpty ? nil : items[items.count - 1]
        }
    }
//: The `topItem` computed property can now be used with any `Stack` instance to access and query its top item without removing it.
    if let topItem = stackOfStrings.topItem {
        print("The top item on the stack is \(topItem).")
    }
//: ## Type Constraints
//: It’s sometimes useful to enforce certain _type constraints_ on the types that can be used with generic functions and generic types. \
//: Type constraints specify that a type parameter must inherit from a specific class, or conform to a particular protocol or protocol composition.
//:
//: For example, Swift’s `Dictionary` type places a limitation on the types that can be used as keys for a dictionary. As described in [Dictionaries](https://developer.apple.com/documentation/swift/dictionary), the type of a dictionary’s keys must be _hashable_. That is, it must provide a way to make itself uniquely representable.
//: `Dictionary` needs its keys to be hashable so that it can check whether it already contains a value for a particular key. \
//: Without this requirement, `Dictionary` could not tell whether it should insert or replace a value for a particular key, nor would it be able to find a value for a given key that is already in the dictionary.
//:
//: You can define your own type constraints when creating custom generic types, and these constraints provide much of the power of generic programming. Abstract concepts like `Hashable` characterize types in terms of their conceptual characteristics, rather than their concrete type.
//: ### Type Constraint Syntax
//: You write type constraints by placing a single class or protocol constraint after a type parameter’s name, separated by a colon, as part of the type parameter list. \
//: The basic syntax for type constraints on a generic function is shown below (although the syntax is the same for generic types):
/*:
 - Example:
 ```
 func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
 }
 ```
 */
//: The hypothetical function above has two type parameters:
//: - The first type parameter, `T`, has a type constraint that requires `T` to be a subclass of `SomeClass`.
//: - The second type parameter, `U`, has a type constraint that requires `U` to conform to the protocol `SomeProtocol`.
//: ### Type Constraints in Action
//: Here’s a nongeneric function called `findIndex(ofString:in:)`, which is given a `String` value to find and an array of `String` values within which to find it.
    func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
//: The `findIndex(ofString:in:)` function can be used to find a string value in an array of strings:
    let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
    if let foundIndex = findIndex(ofString: "llama", in: strings) {
        print("The index of llama is \(foundIndex)")
    }
//: The principle of finding the index of a value in an array isn’t useful only for strings, however. You can write the same functionality as a generic function by replacing any mention of strings with values of some type `T` instead.
//:
//: Here’s how you might expect a generic version of `findIndex(ofString:in:)`, called `findIndex(of:in:)`, to be written:
//:
//: 🧨 _uncomment following lines to see the error_
//:
//    func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
//        for (index, value) in array.enumerated() {
//            if value == valueToFind {
//                return index
//            }
//        }
//        return nil
//    }
//: This function doesn’t compile as written above. The problem lies with the equality check, “`if value == valueToFind`”.
//:
//: Not every type in Swift can be compared with the equal to operator (`==`). If you create your own class or structure to represent a complex data model, for example, then the meaning of “equal to” for that class or structure isn’t something that Swift can guess for you. \
//: Because of this, it isn’t possible to guarantee that this code will work for every possible type `T`, and an appropriate error is reported when you try to compile the code.
//: The Swift standard library defines a protocol called `Equatable`, which requires any conforming type to implement the equal to operator (`==`) and the not equal to operator (`!=`) to compare any two values of that type. \
//: All of Swift’s standard types automatically support the `Equatable` protocol.
//:
//: Any type that is `Equatable` can be used safely with the `findIndex(of:in:)` function, because it’s guaranteed to support the equal to operator.
    func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }

    let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])

    let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
//: ## Associated Types
//: When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition. \
//: An _associated type_ gives a placeholder name to a type that is used as part of the protocol. \
//: The actual type to use for that associated type isn’t specified until the protocol is adopted. \
//: Associated types are specified with the `associatedtype` keyword.
//: ### Associated Types in Action
//: Here’s an example of a protocol called `Container`, which declares an associated type called `Item`:
    protocol Container {
        associatedtype Item
        
        mutating func append(_ item: Item)
        
        var count: Int { get }
        
        subscript(i: Int) -> Item { get }
    }
//: Any type that conforms to the `Container` protocol must be able to specify the type of values it stores. \
//: Specifically, it must ensure that only items of the right type are added to the container, and it must be clear about the type of the items returned by its subscript. \
//: The `Container` protocol needs to specify that any value passed to the `append(_:)` method must have the same type as the container’s element type, and that the value returned by the container’s subscript will be of the same type as the container’s element type. \
//: To achieve this, the `Container` protocol declares an associated type called `Item`, written as `associatedtype Item`. \
//: The protocol doesn’t define what `Item` is—that information is left for any conforming type to provide. \
//: Here’s a version of the nongeneric `IntStack` type adapted to conform to the `Container` protocol:
    struct IntStack: Container {
        // original IntStack implementation
        var items = [Int]()
        
        mutating func push(_ item: Int) {
            items.append(item)
        }
        
        mutating func pop() -> Int {
            return items.removeLast()
        }
        
        // conformance to the Container protocol
        typealias Item = Int // This can be inferred.
        
        mutating func append(_ item: Int) {
            self.push(item)
        }
        
        var count: Int {
            return items.count
        }
        
        subscript(i: Int) -> Int {
            return items[i]
        }
    }
//: Thanks to Swift’s type inference, you don’t actually need to declare a concrete Item of `Int` as part of the definition of `IntStack`. Because `IntStack` conforms to all of the requirements of the `Container` protocol, Swift can infer the appropriate `Item` to use, simply by looking at the type of the `append(_:)` method’s `item` parameter and the return type of the subscript. \
//: Indeed, if you delete the typealias `Item = Int` line from the code above, everything still works, because it’s clear what type should be used for `Item`.
//:
//: You can also make the generic `Stack` type conform to the `Container` protocol:
    struct Stack<Element>: Container {
        // original Stack<Element> implementation
        var items = [Element]()
        
        mutating func push(_ item: Element) {
            items.append(item)
        }
        
        mutating func pop() -> Element {
            return items.removeLast()
        }
        
        // conformance to the Container protocol
        mutating func append(_ item: Element) {
            self.push(item)
        }
        
        var count: Int {
            return items.count
        }
        
        subscript(i: Int) -> Element {
            return items[i]
        }
    }
//: ### Extending an Existing Type to Specify an Associated Type
//: Swift’s `Array` type already provides an `append(_:)` method, a `count` property, and a subscript with an `Int` index to retrieve its elements. These three capabilities match the requirements of the `Container` protocol. This means that you can extend `Array` to conform to the `Container` protocol simply by declaring that `Array` adopts the protocol:
    extension Array: Container {}
//: ### Adding Constraints to an Associated Type
//: You can add type constraints to an associated type in a protocol to require that conforming types satisfy those constraints:
    protocol ContainerOfEquatables {
        associatedtype Item: Equatable
        
        mutating func append(_ item: Item)
        
        var count: Int { get }
        
        subscript(i: Int) -> Item { get }
    }
//: ### Using a Protocol in Its Associated Type’s Constraints
//: A protocol can appear as part of its own requirements.
    protocol SuffixableContainer: Container {
        associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
        func suffix(_ size: Int) -> Suffix
    }

    extension Stack: SuffixableContainer {
    
        func suffix(_ size: Int) -> Stack {
            var result = Stack()
            for index in (count - size)..<count {
                result.append(self[index])
            }
            return result
        }
        // Inferred that Suffix is Stack.
    }

    var stackOfInts = Stack<Int>()
    stackOfInts.append(10)
    stackOfInts.append(20)
    stackOfInts.append(30)
    let suffix = stackOfInts.suffix(2)

    extension IntStack: SuffixableContainer {
        func suffix(_ size: Int) -> Stack<Int> {
            var result = Stack<Int>()
            for index in (count - size)..<count {
                result.append(self[index])
            }
            return result
        }
        // Inferred that Suffix is Stack<Int>.
    }
//: ## Generic Where Clauses
//: It can also be useful to define requirements for associated types. \
//: You do this by defining a _generic where clause_. \
//: A generic `where` clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same.
//: The two containers to be checked don’t have to be the same type of container (although they can be), but they do have to hold the same type of items. This requirement is expressed through a combination of type constraints and a generic `where` clause:
    func allItemsMatch<C1: Container, C2: Container>
        (_ someContainer: C1, _ anotherContainer: C2) -> Bool
        where C1.Item == C2.Item, C1.Item: Equatable {
            
            // Check that both containers contain the same number of items.
            if someContainer.count != anotherContainer.count {
                return false
            }
            
            // Check each pair of items to see if they're equivalent.
            for i in 0..<someContainer.count {
                if someContainer[i] != anotherContainer[i] {
                    return false
                }
            }
            
            // All items match, so return true.
            return true
    }

    var stringsStack = Stack<String>()
    stringsStack.push("uno")
    stringsStack.push("dos")
    stringsStack.push("tres")

    var stringsArray = ["uno", "dos", "tres"]

    if allItemsMatch(stringsStack, stringsArray) {
        print("All items match.")
    } else {
        print("Not all items match.")
    }
//: ## Extensions with a Generic Where Clause
//: You can also use a generic `where` clause as part of an extension.
//:
//: The example below extends the generic `Stack` structure from the previous examples to add an `isTop(_:)` method:
    extension Stack where Element: Equatable {
        func isTop(_ item: Element) -> Bool {
            guard let topItem = items.last else {
                return false
            }
            
            return topItem == item
        }
    }

    if stringsStack.isTop("tres") {
        print("Top element is tres.")
    } else {
        print("Top element is something else.")
    }

//: If you try to call the `isTop(_:)` method on a stack whose elements aren’t equatable, you’ll get a compile-time error:
    struct NotEquatable { }
    var notEquatableStack = Stack<NotEquatable>()
    let notEquatableValue = NotEquatable()
    notEquatableStack.push(notEquatableValue)
//:
//: 🧨 _uncomment following lines to see the error_
//:
//    notEquatableStack.isTop(notEquatableValue)
//: You can use a generic `where` clause with extensions to a protocol:
    extension Container where Item: Equatable {
        func startsWith(_ item: Item) -> Bool {
            return count >= 1 && self[0] == item
        }
    }

    if [9, 9, 9].startsWith(42) {
        print("Starts with 42.")
    } else {
        print("Starts with something else.")
    }
//: The generic `where` clause in the example above requires `Item` to conform to a protocol, but you can also write a generic `where` clauses that require `Item` to be a specific type:
    extension Container where Item == Double {
        func average() -> Double {
            var sum = 0.0
            for index in 0..<count {
                sum += self[index]
            }
            return sum / Double(count)
        }
    }

    print([1260.0, 1200.0, 98.6, 37.0].average())
//: You can include multiple requirements in a generic `where` clause that is part of an extension, just like you can for a generic `where` clause that you write elsewhere. \
//: Separate each requirement in the list with a comma.
//:
//: ## Associated Types with a Generic Where Clause
//: You can include a generic `where` clause on an associated type.
//:
//: For example, suppose you want to make a version of `Container` that includes an iterator, like what the `Sequence` protocol uses in the standard library. \
//: Here’s how you write that:
    protocol ContainerWithIterator {
        associatedtype Item
        
        mutating func append(_ item: Item)
        
        var count: Int { get }
        
        subscript(i: Int) -> Item { get }
        
        associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
        
        func makeIterator() -> Iterator
    }
//: For a protocol that inherits from another protocol, you add a constraint to an inherited associated type by including the generic `where` clause in the protocol declaration:
    protocol ComparableContainer: Container where Item: Comparable { }
//: ## Generic Subscripts
//: Subscripts can be generic, and they can include generic `where` clauses:
    extension Container {
        subscript<Indices: Sequence>(indices: Indices) -> [Item]
            where Indices.Iterator.Element == Int {
                var result = [Item]()
                
                for index in indices {
                    result.append(self[index])
                }
                
                return result
        }
    }
//: This extension to the `Container` protocol adds a subscript that takes a sequence of indices and returns an array containing the items at each given index. \
//: Taken together, these constraints mean that the value passed for the `indices` parameter is a sequence of integers.
//:
//: [Next →](@next)
