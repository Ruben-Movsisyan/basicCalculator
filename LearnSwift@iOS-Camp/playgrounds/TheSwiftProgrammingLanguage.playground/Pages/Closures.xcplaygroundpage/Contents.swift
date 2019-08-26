//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//: # Closures
//: Closures are _self-contained_ blocks of functionality that can be passed around and used in your code. \
//: Closures in Swift are similar to _blocks_ in C and Objective-C and to _lambdas_ in other programming languages. \
//: Closures can capture and store references to any constants and variables from the context in which they are defined.
//: This is known as _closing over_ those constants and variables. \
//: Swift handles all of the memory management of capturing for you.
//: - - -
//: ✏️ _Global_ and _nested functions_ are actually special cases of closures.
//: - - -
//: Closures take one of three forms:
//: * _Global functions are closures_ that have a name and do not capture any values.
//: * _Nested functions are closures_ that have a name and can capture values from their enclosing function.
//: * _Closure expressions_ are unnamed closures written in a lightweight syntax that can capture values from their surrounding context. \
//: Swift’s closure expressions have a clean, clear style, with optimizations that encourage brief, clutter-free syntax in common scenarios. These optimizations include:
//: * Inferring parameter and return value types from context
//: * Implicit returns from single-expression closures
//: * Shorthand argument names
//: * Trailing closure syntax
//: ## Closure Expressions
//: Closure expressions are a way to write inline closures in a brief, focused syntax.
//: ### The Sorted Method
//: The `sorted(by:)` method accepts a closure that takes two arguments of the same type as the array’s contents, and returns a `Bool` value to say whether the first value should appear before or after the second value once the values are sorted:
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }

    var reversedNames = names.sorted(by: backward)
//: - - -
//: ✏️ For characters in strings, “greater than” means “appears later in the alphabet than”.
//: - - -
//: ### Closure Expression Syntax
//: Closure expression syntax has the following general form:
//    { (<#parameters#>) -> <#return type#> in
//        <#statements#>
//    }
//: The _parameters_ in closure expression syntax can be in-out parameters, but they can’t have a default value. \
//: Variadic parameters can be used if you name the variadic parameter. \
//: Tuples can also be used as parameter types and return types.
    reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
        return s1 > s2
    })
//: The start of the closure’s body is introduced by the `in` keyword, which indicates that the definition of the closure’s parameters and return type has finished, and the body of the closure is about to begin. \
//: Because the body of the closure is so short, it can even be written on a single line:
    reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
//: ### Inferring Type From Context
//: The `(String, String)` and `Bool` types do not need to be written as part of the closure expression’s definition. Because all of the types can be inferred, the return arrow (`->`) and the parentheses around the names of the parameters can also be omitted:
    reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
//: - - -
//: ✏️ Making the types explicit is encouraged if it avoids ambiguity for readers of your code.
//: - - -
//: ### Implicit Returns from Single-Expression Closures
//: Single-expression closures can implicitly return the result of their single expression by omitting the `return` keyword from their declaration:
    reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
//: ### Shorthand Argument Names
//: Swift automatically provides shorthand argument names to inline closures, which can be used to refer to the values of the closure’s arguments by the names `$0`, `$1`, `$2`, and so on:
    reversedNames = names.sorted(by: { $0 > $1 } )
//: ### Operator Methods
//: Swift’s `String` type defines its string-specific implementation of the greater-than operator (`>`) as a method that has two parameters of type `String`, and returns a value of type Bool. \
//: This exactly matches the method type needed by the `sorted(by:)` method:
    reversedNames = names.sorted(by: >)
//: ## Trailing Closures
//: A trailing closure is written after the function call’s parentheses, even though it is still an argument to the function. \
//: When you use the trailing closure syntax, you don’t write the argument label for the closure as part of the function call.
    func someFunctionThatTakesAClosure(closure: () -> Void) {
        // function body goes here
    }
//: Here's how you call this function without using a trailing closure:
    someFunctionThatTakesAClosure(closure: {
        // closure's body goes here
    })
//: Here's how you call this function with a trailing closure instead:
    someFunctionThatTakesAClosure() {
        // trailing closure's body goes here
    }
//: The string-sorting closure can be written outside of the `sorted(by:)` method’s parentheses as a trailing closure:
    reversedNames = names.sorted() { $0 > $1 }
//: If a closure expression is provided as the function or method’s only argument and you provide that expression as a trailing closure, you do not need to write a pair of parentheses `()` after the function or method’s name when you call the function:
    reversedNames = names.sorted { $0 > $1 }
//: Use the `map(_:)` method with a trailing closure to convert an array of `Int` values into an array of `String` values:
    let digitNames = [
        0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
        5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
    ]

    let numbers = [16, 58, 510]

    let strings = numbers.map { (number) -> String in
        var number = number
        var output = ""
        repeat {
            output = digitNames[number % 10]! + output
            number /= 10
        } while number > 0
        return output
    }
//: ## Capturing Values
//: A closure can _capture_ constants and variables from the surrounding context in which it is defined. \
//: The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists. \
//: The simplest form of a closure that can capture values is a _nested function_, written within the body of another function. \
//: A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function:
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }

    let incrementByTen = makeIncrementer(forIncrement: 10)

    incrementByTen()

    incrementByTen()

    incrementByTen()

//: The `incrementer()` function doesn’t have any parameters, and yet it refers to `runningTotal` and `amount` from within its function body. It does this by capturing a _reference_ to `runningTotal` and `amount` from the surrounding function and using them within its own function body.
//: - - -
//: ✏️ As an optimization, Swift may instead capture and store a _copy_ of a value if that value is not mutated by a closure, and if the value is not mutated after the closure is created.
//: - - -
//: Swift also handles all memory management involved in disposing of variables when they are no longer needed. \
//: If you create a second incrementer, it will have its own stored reference to a new, separate `runningTotal` variable:
    let incrementBySeven = makeIncrementer(forIncrement: 7)

    incrementBySeven()
//: Calling the original incrementer (`incrementByTen`) again continues to increment its own `runningTotal` variable, and does not affect the variable captured by `incrementBySeven`:
    incrementByTen()
//: - - -
//: ✏️ If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance. Swift uses _capture lists_ to break these strong reference cycles.
//: - - -
//: ## Closures Are Reference Types
//: Functions and closures are _reference types_. \
//: Whenever you assign a function or a closure to a constant or a variable, you are actually setting that constant or variable to be a _reference_ to the function or closure. \
//: if you assign a closure to two different constants or variables, both of those constants or variables refer to the same closure:
    let alsoIncrementByTen = incrementByTen
    alsoIncrementByTen()

    incrementByTen()
//: ## Escaping Closures
//: A closure is said to _escape_ a function when the closure is passed as an argument to the function, but is called after the function returns.
    var completionHandlers: [() -> Void] = []

    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }

    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        closure()
    }

    class SomeClass {
        var x = 10
        func doSomething() {
            someFunctionWithEscapingClosure { self.x = 100 }
            someFunctionWithNonescapingClosure { x = 200 }
        }
    }

    let instance = SomeClass()
    instance.doSomething()
    print(instance.x)

    completionHandlers.first?()
    print(instance.x)
//: - - -
//: ✏️ Marking a closure with `@escaping` means you have to refer to `self` explicitly within the closure.
//: - - -
//: ## Autoclosures
//: An _autoclosure_ is a closure that is automatically created to wrap an expression that’s being passed as an argument to a function. \
//: It doesn’t take any arguments, and when it’s called, it returns the value of the expression that’s wrapped inside of it. \
//: This syntactic convenience lets you omit braces around a function’s parameter by writing a normal expression instead of an explicit closure. \
//: An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure. \
//: The code below shows how a closure delays evaluation:
    var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    print(customersInLine.count)

    let customerProvider = { customersInLine.remove(at: 0) }
    print(customersInLine.count)

    print("Now serving \(customerProvider())!")
    print(customersInLine.count)
//: - - -
//: ✏️ Note that the type of `customerProvider` is not `String` but `() -> String`—a function with no parameters that returns a string.
//: - - -
//: The `serve(customer:)` function in the listing above takes an explicit closure that returns a customer’s name:
    func serve(customer customerProvider: () -> String) {
        print("Now serving \(customerProvider())!")
    }

    serve(customer: { customersInLine.remove(at: 0) } )

//: Call the function as if it took a `String` argument instead of a closure. The argument is automatically converted to a closure:
    func serve(customer customerProvider: @autoclosure () -> String) {
        print("Now serving \(customerProvider())!")
        
    }
    serve(customer: customersInLine.remove(at: 0))
//: - - -
//: ✏️ Overusing autoclosures can make your code hard to understand. The context and function name should make it clear that evaluation is being deferred.
//: - - -
//: If you want an autoclosure that is allowed to escape, use both the `@autoclosure` and `@escaping` attributes:
    var customerProviders: [() -> String] = []

    func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
        customerProviders.append(customerProvider)
    }

    collectCustomerProviders(customersInLine.remove(at: 0))
    collectCustomerProviders(customersInLine.remove(at: 0))

    print("Collected \(customerProviders.count) closures.")

    for customerProvider in customerProviders {
        print("Now serving \(customerProvider())!")
    }
//:
//: [Next →](@next)
