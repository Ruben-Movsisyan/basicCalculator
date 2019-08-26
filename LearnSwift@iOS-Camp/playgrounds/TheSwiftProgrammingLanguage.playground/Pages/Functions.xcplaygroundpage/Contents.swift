//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Functions
//: * _Functions_ are self-contained chunks of code that perform a specific task.
//: * You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.
//: * Swift’s unified function syntax is flexible enough to express anything from a simple C-style function with no parameter names to a complex Objective-C-style method with names and argument labels for each parameter.
//: * Parameters can provide default values to simplify function calls and can be passed as in-out parameters, which modify a passed variable once the function has completed its execution.
//: * Every function has a type, consisting of the function’s parameter types and return type. Use this type like any other type in Swift, which makes it easy to pass functions as parameters to other functions, and to return functions from functions.
//: * Functions can also be written within other functions to encapsulate useful functionality within a nested function scope.
//: * Optionally define one or more named, typed values that the function takes as input, known as parameters.
//: ## Defining and Calling Functions
//: When you define a function, you can optionally define one or more named, typed values that the function takes as input, known as _parameters_.
//: You can also optionally define a type of value that the function will pass back as output when it is done, known as its _return type_.
//: Every function has a _function name_, which describes the task that the function performs. “call” that function with its name and pass it input values (known as _arguments_) that match the types of the function’s parameters.
//: A function’s arguments must always be provided in the same order as the function’s parameter list.
    func greet(person: String) -> String {
        let greeting = "Hello, " + person + "!"
        return greeting
    }
//: All of this information is rolled up into the function’s _definition_, which is prefixed with the `func` keyword.
//: Indicate the function’s return type with the _return arrow_ `->` (a hyphen followed by a right angle bracket), which is followed by the name of the type to return.
//: The `print(_:separator:terminator:)` function doesn’t have a label for its first argument, and its other arguments are optional because they have a default value.
//: To make the body of this function shorter, you can combine the message creation and the return statement into one line:
    func greetAgain(person: String) -> String {
        return "Hello again, " + person + "!"
    }

    print(greetAgain(person: "Anna"))
//: ## Function Parameters and Return Values
//:  Define anything from a simple utility function with a single unnamed parameter to a complex function with expressive parameter names and different parameter options.
//: ### Functions Without Parameters
//: Functions are not required to define input parameters:
    func sayHelloWorld() -> String {
        return "hello, world"
    }

    print(sayHelloWorld())
//: ### Functions With Multiple Parameters
//: Functions input parameters are written within the function’s parentheses, separated by commas:
    func greet(person: String, alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return greetAgain(person: person)
        } else {
            return greet(person: person)
        }
    }

    print(greet(person: "Tim", alreadyGreeted: true))
//: ### Functions Without Return Values
//: Functions are not required to define a return type:
    func greet(person: String) {
        print("Hello, \(person)!")
    }
//    greet(person: "Dave")
//: - - -
//: ✏️ Strictly speaking, this version of the `greet(person:)` function _does_ still return a value, even though no return value is defined. Functions without a defined return type return a special value of type `Void`. This is simply an empty tuple, which is written as `()`.
//: - - -
//: The return value of a function can be ignored when it is called. Because it does not need to return a value, the function’s definition does not include the return arrow (`->`) or a return type:
    func printAndCount(string: String) -> Int {
        print(string)
        return string.count
    }

    func printWithoutCounting(string: String) {
        let _ = printAndCount(string: string)
    }

    printAndCount(string: "hello, world")

    printWithoutCounting(string: "hello, world")
//: - - -
//: ✏️ Return values can be ignored, but a function that says it will return a value must always do so. A function with a defined return type cannot allow control to fall out of the bottom of the function without returning a value, and attempting to do so will result in a compile-time error.
//: - - -
//: ## Functions with Multiple Return Values
//: You can use a tuple type as the return type for a function to return multiple values as part of one compound return value
    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
//: Because the tuple’s member values are named as part of the function’s return type, they can be accessed with dot syntax to retrieve the minimum and maximum found values:
    let bounds = minMax(array: [8, -6, 2, 109, 3, 71])

    print("min is \(bounds.min) and max is \(bounds.max)")
//: Note that the tuple’s members do not need to be named at the point that the tuple is returned from the function, because their names are already specified as part of the function’s return type.
//: ## Optional Tuple Return Types
//: If the tuple type to be returned from a function has the potential to have “no value” for the entire tuple, you can use an _optional_ tuple return type.
//: - - -
//: ✏️ An optional tuple type such as `(Int, Int)?` is different from a tuple that contains optional types such as `(Int?, Int?)`. With an optional tuple type, the entire tuple is optional, not just each individual value within the tuple.
//: - - -
//: To handle an empty array safely, write the `minMax(array:)` function with an optional tuple return type and return a value of `nil` when the array is empty:
    func minMax(array: [Int]) -> (min: Int, max: Int)? {
        if array.isEmpty { return nil }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
//: ## Function Argument Labels and Parameter Names
//: Each function parameter has both an _argument label_ and a _parameter name_.
//: * The argument label is used when calling the function; each argument is written in the function call with its argument label before it.
//: * The parameter name is used in the implementation of the function.
//: * By default, parameters use their parameter name as their argument label.
    func someFunction(firstParameterName: Int, secondParameterName: Int) {
        // In the function body, firstParameterName and secondParameterName
        // refer to the argument values for the first and second parameters.
    }
    someFunction(firstParameterName: 1, secondParameterName: 2)
//: ### Specifying Argument Labels
//: Write an argument label before the parameter name, separated by a space:
    func someFunction(argumentLabel parameterName: Int) {
        // In the function body, parameterName refers to the argument value
        // for that parameter.
    }
//: Here’s a variation of the `greet(person:)` function that takes a person’s name and hometown and returns a greeting:
    func greet(person: String, from hometown: String) -> String {
        return "Hello \(person)!  Glad you could visit from \(hometown)."
    }
    print(greet(person: "Bill", from: "Cupertino"))
//: ### Omitting Argument Labels
//: If you don’t want an argument label for a parameter, write an underscore (`_`) instead of an explicit argument label for that parameter:
    func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
        // In the function body, firstParameterName and secondParameterName
        // refer to the argument values for the first and second parameters.
    }
    someFunction(1, secondParameterName: 2)
//: ### Default Parameter Values
//: You can define a default value for any parameter in a function by assigning a value to the parameter after that parameter’s type:
    func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
    }

    someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6

    someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
//: 🔧 Place parameters that don’t have default values at the beginning of a function’s parameter list, before the parameters that have default values. Parameters that don’t have default values are usually more important to the function’s meaning—writing them first makes it easier to recognize that the same function is being called, regardless of whether any default parameters are omitted. \
//: ### Variadic Parameters
//: * A variadic parameter accepts zero or more values of a specified type.
//: * Use a variadic parameter to specify that the parameter can be passed a varying number of input values when the function is called.
//: * Write variadic parameters by inserting three period characters (`...`) after the parameter’s type name.
//:  * Values passed to a variadic parameter are made available within the function’s body as an array of the appropriate type. For example, a variadic parameter with a name of numbers and a type of `Double...` is made available within the function’s body as a constant array called `numbers` of type `[Double]`.
//: The example below calculates the arithmetic mean (also known as the average) for a list of numbers of any length:
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }

    arithmeticMean(1, 2, 3, 4, 5)

    arithmeticMean(3, 8.25, 18.75)
//: - - -
//: ✏️ A function may have at most one variadic parameter.
//: - - -
//: ### In-Out Parameters
//: * Function parameters are constants by default. Trying to change the value of a function parameter from within the body of that function results in a compile-time error.
//: * This means that you can’t change the value of a parameter by mistake. If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an _in-out_ parameter instead.
//: * Write an in-out parameter by placing the `inout` keyword right before a parameter’s type.
//: * You can only pass a variable as the argument for an in-out parameter. You cannot pass a constant or a literal value as the argument, because constants and literals cannot be modified. You place an ampersand (`&`) directly before a variable’s name when you pass it as an argument to an in-out parameter, to indicate that it can be modified by the function.
//: - - -
//: ✏️ In-out parameters cannot have default values, and variadic parameters cannot be marked as `inout`.
//: - - -
//: Here’s an example of a function called `swapTwoInts(_:_:)`, which has two in-out integer parameters called `a` and `b`:
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

    var someInt = 3
    var anotherInt = 107
    swapTwoInts(&someInt, &anotherInt)
    print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
//: - - -
//: ✏️ In-out parameters are not the same as returning a value from a function. The `swapTwoInts` example above does not define a return type or return a value, but it still modifies the values of `someInt` and `anotherInt`. In-out parameters are an alternative way for a function to have an effect outside of the scope of its function body.
//: - - -
//: ## Function Types
//: Every function has a specific _function type_, made up of the parameter types and the return type of the function. The type of both of these functions is `(Int, Int) -> Int`:
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
//: Here's a function with no parameters and return value. The type of this function is `() -> Void`:
    func printHelloWorld() {
        print("hello, world")
    }
//: ### Using Function Types
//: Define a constant or variable to be of a function type and assign an appropriate function to that variable:
    var mathFunction: (Int, Int) -> Int = addTwoInts
//: You can now call the assigned function with the name `mathFunction`:
    print("Result: \(mathFunction(2, 3))")
//: A different function with the same matching type can be assigned to the same variable, in the same way as for nonfunction types:
    mathFunction = multiplyTwoInts

    print("Result: \(mathFunction(2, 3))")
//: Swift to infers the function type when you assign a function to a constant or variable:
    let anotherMathFunction = addTwoInts
//: ### Function Types as Parameter Types
//: Use a function type such as `(Int, Int) -> Int` as a parameter type for another function:
    func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result: \(mathFunction(a, b))")
    }

    printMathResult(addTwoInts, 3, 5)
//: ### Function Types as Return Types
//: Use a function type as the return type of another function:
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }

    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }

    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        return backward ? stepBackward : stepForward
    }

    var currentValue = 3
    let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)

    print("Counting to zero:")
    // Counting to zero:
    while currentValue != 0 {
        print("\(currentValue)... ")
        currentValue = moveNearerToZero(currentValue)
    }
    print("zero!")
//: ## Nested Functions
//: All of the functions you have encountered so far in this chapter have been examples of _global functions_, which are defined at a global scope. \
//: You can also define functions inside the bodies of other functions, known as _nested functions_.
//: Nested functions are hidden from the outside world by default, but can still be called and used by their enclosing function. An enclosing function can also return one of its nested functions to allow the nested function to be used in another scope.
//    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
//        func stepForward(input: Int) -> Int { return input + 1 }
//        func stepBackward(input: Int) -> Int { return input - 1 }
//        return backward ? stepBackward : stepForward
//    }
//
//    var currentValue = -4
//    let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
//    // moveNearerToZero now refers to the nested stepForward() function
//    while currentValue != 0 {
//        print("\(currentValue)... ")
//        currentValue = moveNearerToZero(currentValue)
//    }
//    print("zero!")
//:
//: [Next →](@next)
