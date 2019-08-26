//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Control Flow
//: Swift provides a variety of control flow statements. These include:
//: * A `for-in` loop that makes it easy to iterate over arrays, dictionaries, ranges, strings, and other sequences.
//: * `while` loops to perform a task multiple times.
//: * `if`, `guard`, and `switch` statements to execute different branches of code based on certain conditions.
//: * Statements such as `break` and `continue` to transfer the flow of execution to another point in your code.
//: ## For-In Loops
//: Use the `for-in` loop to iterate over a sequence, such as items in an array, ranges of numbers, or characters in a string: \
//: Iterate over the items in an array:
    let names = ["Anna", "Alex", "Brian", "Jack"]

    for name in names {
        print("Hello, \(name)!")
    }
//: Iterate over a dictionary to access its key-value pairs:
    let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]

    for (animalName, legCount) in numberOfLegs {
        print("\(animalName)s have \(legCount) legs")
    }
//: - - -
//: ✏️ The contents of a Dictionary are inherently unordered, and iterating over them does not guarantee the order in which they will be retrieved.
//: - - -
//: Use `for-in` loops with numeric ranges:
    for index in 1...5 {
        print("\(index) times 5 is \(index * 5)")
    }
//: - - -
//: ✏️ In the example above, `index` is a constant whose value is automatically set at the start of each iteration of the loop. As such, index does not have to be declared before it is used. It is implicitly declared simply by its inclusion in the loop declaration, without the need for a `let` declaration keyword.
//: - - -
//: You can ignore the values by using an underscore (`_`) in place of a variable name:
    let base = 3
    let power = 10
    var answer = 1

    for _ in 1...power {
        answer *= base
    }

    print("\(base) to the power of \(power) is \(answer)")
//: Use the half-open range operator (`..<`) to include the lower bound but not the upper bound:
    let minutes = 60

    for tickMark in 0..<minutes {
        tickMark // render the tick mark each minute (60 times)
    }
//: Use the `stride(from:to:by:`) function to skip the unwanted marks:
    let minuteInterval = 5

    for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
        tickMark // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
    }
//: Closed ranges are also available, by using stride(from:through:by:) instead:
    let hours = 12
    let hourInterval = 3

    for tickMark in stride(from: 3, through: hours, by: hourInterval) {
        tickMark
    }
//: ## While Loops
//: A `while` loop performs a set of statements until a condition becomes `false`. These kinds of loops are best used when the number of iterations is not known before the first iteration begins. Swift provides two kinds of while loops:
//: * `while` evaluates its condition at the start of each pass through the loop.
//: * `repeat-while` evaluates its condition at the end of each pass through the loop.
//: ### While
//: Here’s the general form of a while loop:
//    while <#condition#> {
//        <#statements#>
//    }
//:  For example:
    var secondsLeft = 5

    while secondsLeft != 0 {
        print("Countdown: \(secondsLeft)")
        secondsLeft -= 1
    }
//: ### Repeat-While
//: `repeat-while` loop, performs a single pass through the loop block first, before considering the loop’s condition. It then continues to repeat the loop until the condition is `false`.
//: - - -
//: ✏️ The `repeat-while` loop in Swift is analogous to a `do-while` loop in other languages.
//: - - -
//: Here’s the general form of a repeat-while loop:
//    repeat {
//        <#statements#>
//    } while <#condition#>
//: Example:
    var progress = 0

    repeat {
        progress += 10
    } while progress < 100
//: ## Conditional Statements
//: Swift provides two ways to add conditional branches to your code: the `if` statement and the `switch` statement.
//: ## If
//: In its simplest form, the `if` statement has a single `if` condition. It executes a set of statements only if that condition is `true`:
    var temperatureInFahrenheit = 30

    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    }
//: The `if` statement can provide an alternative set of statements, known as an `else` clause:
    temperatureInFahrenheit = 40

    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else {
        print("It's not that cold. Wear a t-shirt.")
    }
//: You can chain multiple `if` statements together to consider additional clauses:
    temperatureInFahrenheit = 90
    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else if temperatureInFahrenheit >= 86 {
        print("It's really warm. Don't forget to wear sunscreen.")
    } else {
        print("It's not that cold. Wear a t-shirt.")
    }
//: The final `else` clause is optional, however, and can be excluded if the set of conditions does not need to be complete:
    temperatureInFahrenheit = 72
    if temperatureInFahrenheit <= 32 {
        print("It's very cold. Consider wearing a scarf.")
    } else if temperatureInFahrenheit >= 86 {
        print("It's really warm. Don't forget to wear sunscreen.")
    }
//: ## Switch
//: A `switch` statement considers a value and compares it against several possible matching patterns. It then executes an appropriate block of code, based on the first pattern that matches successfully. A `switch` statement provides an alternative to the `if` statement for responding to multiple potential states. \
//: In its simplest form, a `switch` statement compares a value against one or more values of the same type:
//    switch <#some value to consider#> {
//    case <#value 1#>:
//        <#respond to value 1#>
//    case <#value 2#>,
//         <#value 3#>:
//        <#respond to value 2 or 3#>
//    default:
//        <#otherwise, do something else#>
//    }
//: * Every `switch` statement consists of multiple possible _cases_.
//: * The `switch` statement determines which `case` should be selected. This is known as _switching_ on the value that is being considered.
//: * Every `switch` statement must be _exhaustive_. That is, every possible value of the type being considered must be matched by one of the switch cases. \
//: Define the `default` case to cover any values that are not addressed explicitly:
    let someCharacter: Character = "z"

    switch someCharacter {
    case "a":
        print("The first letter of the alphabet")
    case "z":
        print("The last letter of the alphabet")
    default:
        print("Some other character")
    }
//: ### No Implicit Fallthrough
//: Switch statements in Swift do not fall through the bottom of each case and into the next one by default. Instead, the entire `switch` statement finishes its execution as soon as the first matching `switch` case is completed, without requiring an explicit `break` statement.
//: - - -
//: ✏️ Although `break` is not required in Swift, you can use a `break` statement to match and ignore a particular case or to break out of a matched case before that case has completed its execution.
//: - - -
//: The body of each case _must_ contain at least one executable statement. \
//: It is not valid to write the following code, because the first case is empty:
//:
//: 🧨 _uncomment following lines to see the error_
//:
//    let anotherCharacter: Character = "a"
//    switch anotherCharacter {
//    case "a": // Invalid, the case has an empty body
//    case "A":
//        print("The letter A")
//    default:
//        print("Not the letter A")
//    }
//: This approach avoids accidental fallthrough from one case to another and makes for safer code that is clearer in its intent. \
//: To make a switch with a single case that matches both `"a"` and `"A"`, combine the two values into a compound case, separating the values with commas:
    let anotherCharacter: Character = "a"
    switch anotherCharacter {
    case "a", "A":
        print("The letter A")
    default:
        print("Not the letter A")
    }
//: - - -
//: 🔧 To explicitly fall through at the end of a particular `switch` case, use the `fallthrough` keyword.
//: - - -
//: ### Interval Matching
//: Values in `switch` cases can be checked for their inclusion in an interval. This example uses number intervals to provide a natural-language count for numbers of any size:
    let approximateCount = 62
    let countedThings = "moons orbiting Saturn"
    let naturalCount: String

    switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5:
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    case 100..<1000:
        naturalCount = "hundreds of"
    default:
        naturalCount = "many"
    }
    print("There are \(naturalCount) \(countedThings).")
//: ## Tuples
//: Use tuples to test multiple values in the same `switch` statement. Each element of the tuple can be tested against a different value or interval of values. Use the underscore character (`_`), also known as the wildcard pattern, to match any possible value.
//:
//: The example below takes an (`x, y`) point, expressed as a simple tuple of type (`Int, Int`), and categorizes it on the graph that follows the example:
    let somePoint = (1, 1)

    switch somePoint {
    case (0, 0):
        print("\(somePoint) is at the origin")
    case (_, 0):
        print("\(somePoint) is on the x-axis")
    case (0, _):
        print("\(somePoint) is on the y-axis")
    case (-2...2, -2...2):
        print("\(somePoint) is inside the box")
    default:
        print("\(somePoint) is outside of the box")
    }
//:
//: ![Coordinate Graph](coordinateGraphSimple_2x.png)
//:
//: - - -
//: ✏️ The point `(0, 0)` could match all four of the cases in this example. However, if multiple matches are possible, the first matching case is always used. The point `(0, 0)` would match case `(0, 0)` first, and so all other matching cases would be ignored.
//: - - -
//: ### Value Bindings
//: A `switch` case can name the value or values it matches to temporary constants or variables, for use in the body of the case. This behavior is known as _value binding_. \
//: The example below takes an (`x, y`) point, expressed as a tuple of type (`Int, Int`), and categorizes it on the graph that follows:
    let anotherPoint = (2, 0)

    switch anotherPoint {
    case (let x, 0):
        print("on the x-axis with an x value of \(x)")
    case (0, let y):
        print("on the y-axis with a y value of \(y)")
    case let (x, y):
        print("somewhere else at (\(x), \(y))")
}
//: ![Coordinate Graph Medium](coordinateGraphMedium_2x.png)
//: The `switch` statement determines whether the point is on the red x-axis, on the orange y-axis, or elsewhere (on neither axis).
//: ### Where
//: A `switch` case can use a `where` clause to check for additional conditions.
//:
//: The example below categorizes an (x, y) point on the following graph:
    let yetAnotherPoint = (1, -1)

    switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
    }
//: ![Coordinate Graph Complex](coordinateGraphComplex_2x.png)
//: The `switch` statement determines whether the point is on the green diagonal line where `x == y`, on the purple diagonal line where `x == -y`, or neither.
//: ### Compound Cases
//: Multiple `switch` cases that share the same body can be combined by writing several patterns after `case`, with a comma between each of the patterns:
    let aCharacter: Character = "e"

    switch aCharacter {
    case "a", "e", "i", "o", "u":
        print("\(aCharacter) is a vowel")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
        print("\(aCharacter) is a consonant")
    default:
        print("\(aCharacter) is not a vowel or a consonant")
    }
//: Compound cases can also include value bindings:
    let stillAnotherPoint = (9, 0)

    switch stillAnotherPoint {
    case (let distance, 0), (0, let distance):
        print("On an axis, \(distance) from the origin")
    default:
        print("Not on an axis")
    }
//: ## Control Transfer Statements
//: Control transfer statements change the order in which your code is executed, by transferring control from one piece of code to another. Swift has five control transfer statements:
//: * `continue`
//: * `break`
//: * `fallthrough`
//: * `return`
//: * `throw`
//:
//: ### Continue
//: The `continue` statement tells a loop to stop what it is doing and start again at the beginning of the next iteration through the loop.
//: The following example removes all vowels and spaces from a lowercase string to create a cryptic puzzle phrase:
    let puzzleInput = "great minds think alike"
    var puzzleOutput = ""
    let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]

    for character in puzzleInput {
        if charactersToRemove.contains(character) {
            continue
        }
        puzzleOutput.append(character)
    }
    print(puzzleOutput)
//: ### Break
//: The `break` statement ends execution of an entire control flow statement immediately. The `break` statement can be used inside a `switch` or loop statement when you want to terminate the execution of the `switch` or loop statement earlier than would otherwise be the case.
//: ### Break in a Loop Statement
//: When used inside a loop statement, `break` ends the loop’s execution immediately and transfers control to the code after the loop’s closing brace (`}`).
//: ### Break in a Switch Statement
//: When used inside a `switch` statement, `break` causes the switch statement to end its execution immediately and to transfer control to the code after the switch statement’s closing brace (`}`).
//: - - -
//: ✏️ Because Swift’s `switch` statement is exhaustive and does not allow empty cases, it is sometimes necessary to deliberately match and ignore a case in order to make your intentions explicit.
//: - - -
//: - - -
//: ✏️ A `switch` case that contains only a comment is reported as a compile-time error. Comments are not statements and do not cause a `switch` case to be ignored. Always use a `break` statement to ignore a `switch` case.
//: - - -
//: The following example switches on a `Character` value and determines whether it represents a number symbol in one of four languages. For brevity, multiple values are covered in a single switch case:
    let numberSymbol: Character = "三"  // Chinese symbol for the number 3
    var possibleIntegerValue: Int?

    switch numberSymbol {
    case "1", "١", "一", "๑":
        possibleIntegerValue = 1
    case "2", "٢", "二", "๒":
        possibleIntegerValue = 2
    case "3", "٣", "三", "๓":
        possibleIntegerValue = 3
    case "4", "٤", "四", "๔":
        possibleIntegerValue = 4
    default:
        break
    }

    if let integerValue = possibleIntegerValue {
        print("The integer value of \(numberSymbol) is \(integerValue).")
    } else {
        print("An integer value could not be found for \(numberSymbol).")
    }
//: ### Fallthrough
//: In Swift, `switch` statements don’t fall through the bottom of each case and into the next one.
//:
//: If you need C-style fallthrough behavior, you can opt in to this behavior on a case-by-case basis with the `fallthrough` keyword. The example below uses `fallthrough` to create a textual description of a number:
    let integerToDescribe = 5
    var description = "The number \(integerToDescribe) is"

    switch integerToDescribe {
    case 2, 3, 5, 7, 11, 13, 17, 19:
        description += " a prime number, and also"
        fallthrough
    default:
        description += " an integer."
    }

    print(description)
//: - - -
//: ✏️ The `fallthrough` keyword does not check the case conditions for the `switch` case that it causes execution to fall into. The `fallthrough` keyword simply causes code execution to move directly to the statements inside the next case (or `default` case) block, as in C’s standard `switch` statement behavior.
//: - - -
//: ### Labeled Statements
//: Loops and conditional statements can both use the `break` statement to end their execution prematurely. Therefore, it is sometimes useful to be explicit about which loop or conditional statement you want a `break` statement to terminate. Similarly, if you have multiple nested loops, it can be useful to be explicit about which loop the `continue` statement should affect.
//:
//: You can mark a loop statement or conditional statement with a _statement label_.
//: A labeled statement is indicated by placing a label on the same line as the statement’s introducer keyword, followed by a colon:
//        <#label name#>: while <#condition#> {
//            <#statements#>
//        }
//: The objective of the following game is to collect exactly 21 points to win. Player loses when his `points` exceed the number of `winPoints`.
    let winPoints = 21

    gameLoop: while true { // Infinite game loop
        var points = 0
        
        roundLoop: while true {
            points += Int.random(in: 1...6)
            
            switch points {
            case let p where p < winPoints:
                continue roundLoop
            case let p where p == winPoints:
                print("You won!")
                break gameLoop
            case let p where p > winPoints:
                print("You've lost the round by collecting: \(points) points.")
                break roundLoop
            default:
                continue gameLoop
            }
        }
    }
//: ## Early Exit
//: * A `guard` statement, like an `if` statement, executes statements depending on the Boolean value of an expression.
//: * Use a guard statement to _require_ that a condition must be true in order for the code after the guard statement to be executed.
//: * Unlike an if statement, a guard statement always has an `else` clause.
    func greet(person: [String: String]) {
        guard let name = person["name"] else {
            return
        }
        
        print("Hello \(name)!")
        
        guard let location = person["location"] else {
            print("I hope the weather is nice near you.")
            return
        }
        
        print("I hope the weather is nice in \(location).")
    }

    greet(person: ["name": "John"])

    greet(person: ["name": "Jane", "location": "Cupertino"])
//: If the `guard` statement’s condition is met, code execution continues after the `guard` statement’s closing brace. Any variables or constants that were assigned values using an optional binding as part of the condition are available for the rest of the code block that the guard statement appears in. \
//: If that condition is not met, the code inside the `else` branch is executed. That branch must transfer control to exit the code block in which the `guard` statement appears. It can do this with a control transfer statement such as `return`, `break`, `continue`, or `throw`, or it can call a function or method that doesn’t return, such as `fatalError(_:file:line:)`. \
//: - - -
//: ✏️ Using a `guard` statement for requirements improves the readability of your code, compared to doing the same check with an `if` statement. It lets you write the code that’s typically executed without wrapping it in an `else` block, and it lets you keep the code that handles a violated requirement next to the requirement.
//: - - -
//: ## Checking API Availability
//: Swift has built-in support for checking API availability, which ensures that you don’t accidentally use APIs that are unavailable on a given deployment target. Swift reports an error at compile time if you try to use an API that isn’t available.
//: You use an _availability condition_ in an `if` or `guard` statement to conditionally execute a block of code, depending on whether the APIs you want to use are available at runtime:
    if #available(iOS 10, macOS 10.12, *) {
        // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
    } else {
        // Fall back to earlier iOS and macOS APIs
    }
//: - - -
//: ✏️ The last argument, `*`, is required and specifies that on _any other platform_, the body of the if executes on the _minimum deployment target_ specified by your target.
//: - - -
//: In its general form, the availability condition takes a list of platform names and versions. You use platform names such as `iOS`, `macOS`, `watchOS`, and `tvOS`:
//    if #available(<#platform name#> <#version#>, ..., *) {
//        <#statements to execute if the APIs are available#>
//    } else {
//        <#fallback statements to execute if the APIs are unavailable#>
//    }
//:
//: [Next →](@next)
