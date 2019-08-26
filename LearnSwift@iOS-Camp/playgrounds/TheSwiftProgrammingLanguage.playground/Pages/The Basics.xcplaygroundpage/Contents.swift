//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # The Basics
//: Swift provides its own versions of all fundamental C and Objective-C types:
//: * `Int` for *integers*.
//: * `Double` and `Float` for *floating-point* values.
//: * `Bool` for *Boolean* values.
//: * `String` for *textual* data. \
//: Swift provides three primary *collection types*:
//: * `Array`
//: * `Set`
//: * `Dictionary` \
//: Swift also:
//: * Uses **variables** and **constants**.
//: * Introduces **tuples**.
//: * Introduces **optional types**.
//: * Is a **type-safe** language.
//: ## Constants and Variables
//: The value of a _constant_ can’t be changed once it’s set, whereas a _variable_ can be set to a different value in the future.
//: ### Declaring Constants and Variables
//: Declare:
//: * _Constants_ with the `let` keyword.
//: * _Variables_ with the `var` keyword.
    let maximumNumberOfLoginAttempts = 10
    var currentLoginAttempt = 0
//: Declare multiple constants or multiple variables on a single line, separated by commas:
    var x = 0.0, y = 0.0, z = 0.0
//: ### Type Annotations
//: Provide a _type annotation_ when declaring a constant or variable:
    var welcomeMessage: String
//: The `welcomeMessage` variable can now be set to any string value without error:
    welcomeMessage = "Hello"
//: Define multiple related variables of the same type on a single line:
    var red, green, blue: Double
//: ### Naming Constants and Variables
//: Constant and variable names can contain almost any character, including Unicode characters:
    let π = 3.14159
    let 你好 = "你好世界"
    let 🐶🐮 = "dogcow"
//: - - -
//: ✏️ Constant and variable names can’t contain _whitespace_ characters, mathematical symbols, arrows, private-use Unicode scalar values, or line- and box-drawing characters. Nor can they begin with a number, although numbers may be included elsewhere within the name.
//: - - -
//: - - -
//: 🔧 When it's needed to give a constant or variable the same name as a reserved Swift keyword, surround the keyword with **backticks (`)** when using it as a name. However, avoid using keywords as names unless there is absolutely no choice.
//: - - -
//: Change the value of an existing variable to another value of a compatible type:
    var friendlyWelcome = "Hello!"
    friendlyWelcome = "Bonjour!"
    // friendlyWelcome is now "Bonjour!"
//: ### Printing Constants and Variables
//: Print the current value of a constant or variable with the `print(_:separator:terminator:`) function:
print(friendlyWelcome)
//: - - -
//: 🔧 To print a value _without a line break_ after it, pass an empty string as the terminator—for example, `print(someValue, terminator: ""`).
//: - - -
//: ## Comments
//: Used to include _nonexecutable_ text in code. \
//: _Single-line_ comments:
    // This is a comment.
//: _Multiline_ comments:
    /* This is also a comment
    but is written over multiple lines. */
//: _Nested multiline_ comments:
    /* This is the start of the first multiline comment.
    /* This is the second, nested multiline comment. */
    This is the end of the first multiline comment. */
//: ## Semicolons
//: Swift doesn’t require to write a semicolon (`;`) after each statement in code, although it's possible:
    let cat = "🐱"
print(cat)
//: ## Integers
//: * Whole numbers with no fractional component, such as `42` and `-23`.
//: * Are either _signed_ (positive, zero, or negative) or _unsigned_ (positive or zero).
//: * Swift provides signed and unsigned integers in 8, 16, 32, and 64 bit forms.
//: ### Integer Bounds
//: Access the _minimum_ and _maximum_ values of each integer type with its `min` and `max` properties:
    let minValue = Int8.min  // minValue is equal to 0, and is of type UInt8
    let maxValue = UInt64.max  // maxValue is equal to 255, and is of type UInt8
//: ### Int
//: * On a 32-bit platform, `Int` is the same size as `Int32`.
//: * On a 64-bit platform, `Int` is the same size as `Int64`.
//: - - -
//: ✏️ Unless it's needed to work with a specific size of integer, always use `Int` for integer values. This aids code consistency and interoperability. \
//: Even on 32-bit platforms, `Int` can store any value between -2,147,483,648 and 2,147,483,647, and is large enough for many integer ranges.
//: - - -
//: ### UInt
//: * On a 32-bit platform, `UInt` is the same size as `UInt32`.
//: * On a 64-bit platform, `UInt` is the same size as `UInt64`.
//: - - -
//: ✏️ Use `UInt` only when there's a need for an unsigned integer type with the same size as the platform’s _native word size_.
//: If this isn’t the case, `Int` is preferred, even when the values to be stored are known to be nonnegative.
//: - - -
//: ## Floating-Point Numbers
//: Numbers with a fractional component, such as 3.14159, 0.1, and -273.15.
//: * `Double` represents a 64-bit floating-point number.
//: * `Float` represents a 32-bit floating-point number.
//: - - -
//: ✏️
//: * `Double` has a precision of at least 15 decimal digits.
//: * `Float` can be as little as 6 decimal digits.
//: * When either type would do, `Double` is preferred.
//: - - -
//: ## Type Safety and Type Inference
//: * Swift is a _type-safe_ language.
//: * It performs _type checks_ when compiling code and flags any mismatched types as errors.
//: * Uses _type inference_ to work out the appropriate type. \
//: Type inference is particularly useful when declaring a constant or variable and initialize them by assigning a _literal value_:
    let meaningOfLife = 42
    // meaningOfLife is inferred to be of type Int

    let pi = 3.14159
    // pi is inferred to be of type Double
//: ✏️ Swift always chooses `Double` (rather than `Float`) when inferring the type of floating-point numbers.
    let anotherPi = 3 + 0.14159
    // anotherPi is also inferred to be of type Double
//: ## Numeric Literals
//: Integer literals can be written as:
//: * A _decimal_ number, with no prefix.
//: * A _binary_ number, with a `0b` prefix.
//: * An _octal_ number, with a `0o` prefix.
//: * A _hexadecimal_ number, with a `0x` prefix. \
//: All of these integer literals have a decimal value of `17`:
    let decimalInteger = 17
    let binaryInteger = 0b10001       // 17 in binary notation
    let octalInteger = 0o21           // 17 in octal notation
    let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
//: Decimal and hexadecimal floats can also have an optional exponent.
//: All of these floating-point literals have a decimal value of `12.1875`:
    let decimalDouble = 12.1875
    let exponentDouble = 1.21875e1
    let hexadecimalDouble = 0xC.3p0
//: Numeric literals can contain extra formatting to make them easier to read:
    let paddedDouble = 000123.456
    let oneMillion = 1_000_000
    let justOverOneMillion = 1_000_000.000_000_1
//: ## Numeric Type Conversion
//: * Use the `Int` type for all general-purpose integer constants and variables in code.
//: * Use other integer types only when they’re specifically needed for the task at hand.
//: ### Integer Conversion
//: * An `Int8` constant or variable can store numbers between `-128` and `127`.
//: `UInt8` constant or variable can store numbers between `0` and `255`. \
//: 🧨 _uncomment following lines to see the error_
//     let cannotBeNegative: UInt8 = -1
//     // UInt8 cannot store negative numbers, and so this will report an error
//     let tooBig: Int8 = Int8.max + 1
//     // Int8 cannot store a number larger than its maximum value, and so this will also report an error.
////: Opt in to numeric type conversion on a case-by-case basis:
    let twoThousand: UInt16 = 2_000
    let one: UInt8 = 1
    let twoThousandAndOne = twoThousand + UInt16(one)
//: ### Integer and Floating-Point Conversion
//: Conversions between integer and floating-point numeric types must be made explicit:
    let three = 3
    let pointOneFourOneFiveNine = 0.14159
    let պի = Double(three) + pointOneFourOneFiveNine
    type(of: պի)
//: Floating-point to integer conversion must also be made explicit:
    let integerPi = Int(pi)
    // integerPi equals 3, and is inferred to be of type Int
//: ## Type Aliases
//: Define an alternative name for an existing type. \
//: Define type aliases with the `typealias` keyword:
    typealias AudioSample = UInt16

    var maxAmplitudeFound = AudioSample.max
//: ## Booleans
//: Swift has a basic _Boolean_ type, called `Bool`. \
//: Swift provides two Boolean constant values, `true` and `false`:
    let orangesAreOrange = true
    let turnipsAreDelicious = false
//: Boolean values are particularly useful while working with conditional statements such as the `if` statement:
    if turnipsAreDelicious {
        print("Mmm, tasty turnips!")
    } else {
        print("Eww, turnips are horrible.")
    }
//: Swift’s type safety prevents _non-Boolean_ values from being substituted for `Bool`: \
//: 🧨 _uncomment following lines to see the error_
//    let i = 1
//    if i {
//        // this example will not compile, and will report an error
//    }

    let i = 1
    if i == 1 {
        // this example will compile successfully
    }
//: ## Tuples
//: Used to group multiple values into a single compound value:
    let http404Error = (404, "Not Found")
    // http404Error is of type (Int, String), and equals (404, "Not Found")
type(of: http404Error)
//: _Decompose_ a tuple’s contents into separate constants or variables, which then can be accessed as usual:
    let (statusCode, statusMessage) = http404Error
    print("The status code is \(statusCode)")

    print("The status message is \(statusMessage)")
//: Ignore parts of the tuple with an underscore (`_`) when decomposing the tuple:
    let (justTheStatusCode, _) = http404Error
    print("The status code is \(justTheStatusCode)")
//: Access the individual element values in a tuple using index numbers starting at zero:
    print("The status code is \(http404Error.0)")

    print("The status message is \(http404Error.1)")
//: Name the individual elements in a tuple when the tuple is defined:
    let http200Status = (statusCode: 200, description: "OK")

    print("The status code is \(http200Status.statusCode)")

    print("The status message is \(http200Status.description)")
//: - - -
//: ✏️ Tuples are useful for temporary groups of related values and are not suited for the creation of complex data structures.
//: - - -
//: ## Optionals
//: Used in situations where a value may be absent.
//: - - -
//: ✏️ The concept of optionals doesn’t exist in C or Objective-C. The nearest thing in Objective-C is the ability to return `nil` from a method that would otherwise return an object, with nil meaning “the absence of a valid object.” However, this only works for objects—it doesn’t work for structures, basic C types, or enumeration values. For these types, Objective-C methods typically return a special value (such as `NSNotFound`) to indicate the absence of a value. This approach assumes that the method’s caller knows there’s a special value to test against and remembers to check for it. Swift’s optionals let you indicate the absence of a value for any type at all, without the need for special constants.
//: - - -
//: `Int` initializer which tries to convert a `String` value into an `Int` may fail, so it returns an `Int?` (_optional_ `Int`):
    let possibleNumber = "lm"
    let convertedNumber = Int(possibleNumber)
    type(of: convertedNumber)
//: ### nil
//: Set an optional variable to a valueless state by assigning it the special value `nil`:
    var serverResponseCode: Int? = 404

    serverResponseCode = nil
//: When an optional variable defined without providing a default value, the variable is automatically set to `nil`:
    var surveyAnswer: String?
//: - - -
//: ✏️ In Objective-C, `nil` is a pointer to a nonexistent object. In Swift, `nil` isn’t a pointer—it’s the absence of a value of a certain type. Optionals of any type can be set to nil, not just object types.
//: - - -
//: ### If Statements and Force Unwrapping
//: If an optional has a value, it’s considered to be “not equal to” `nil`:
    if convertedNumber == nil {
        print("convertedNumber contains some integer value.")
    }
//: Access optional's underlying value by adding an exclamation mark (`!`) to the end of the optional’s name, when you’re sure that the optional does contain a value. \
//: This is known as forced unwrapping of the optional’s value:
    if convertedNumber != nil {
        print("convertedNumber has an integer value of \(convertedNumber!).")
    }
//: - - -
//: ✏️ Trying to use `!` to access a _nonexistent_ optional value triggers a runtime error.
//: - - -
//: ### Optional Binding
//: Used to find out whether an optional contains a value.
//: Write an optional binding for an if statement as follows: \
//:     if let constantName = someOptional {
//:         statements
//:     }
//: Use optional binding rather than forced unwrapping:
    if let actualNumber = Int(possibleNumber) {
        print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
    } else {
        print("The string \"\(possibleNumber)\" could not be converted to an integer")
    }
//: Include as many optional bindings and Boolean conditions in a single `if` statement as needed, separated by commas:
    if let firstNumber = Int("4"), let secondNumber = Int("42"),
        firstNumber < secondNumber && secondNumber < 100 {
        print("\(firstNumber) < \(secondNumber) < 100")
    }
//: - - -
//: ✏️ Constants and variables created with optional binding in an `if` statement are available only within the body of the `if` statement.
//: - - -
//: ### Implicitly Unwrapped Optionals
//: Used when an optional is confirmed to have a value:
    let possibleString: String? = "An optional string."
    let forcedString: String = possibleString! // requires an exclamation mark

    let assumedString: String! = "An implicitly unwrapped optional string."
    let implicitString: String = assumedString // no need for an exclamation mark
//: Treat an implicitly unwrapped optional like a normal optional:
    if assumedString != nil {
        print(assumedString!)
    }
//: Use implicitly unwrapped optional with optional binding:
    if let definiteString = assumedString {
        print(definiteString)
    }
//: ## Error Handling
//: Used to respond to error conditions a program may encounter during execution.
//: When a function encounters an error condition, it _throws_ an error. That function’s caller can then _catch_ the error and respond appropriately.
    func canThrowAnError() throws {
        // this function may or may not throw an error
    }

    do {
        try canThrowAnError()
        // no error was thrown
    } catch {
        // an error was thrown
    }
//: ## Assertions and Preconditions
//: Are checks that happen at runtime, which are used to make sure an essential condition is satisfied before executing any further code. \
//: Assertions are checked only in debug builds, but preconditions are checked in both debug and production builds.
//: ### Debugging with Assertions
//: Write an assertion by calling the `assert(_:_:file:line:`) function:
    let age = -3
//: 🧨 _uncomment following lines to see the error_ \
//    assert(age >= 0, "A person's age can't be less than zero.")
    // This assertion fails because -3 is not >= 0.
//: If the code already checks the condition, use the `assertionFailure(_:file:line:`) function to indicate that an assertion has failed:
    if age > 10 {
        print("You can ride the roller-coaster or the ferris wheel.")
    } else if age >= 0 {
        print("You can ride the ferris wheel.")
    } else {
//: 🧨 _uncomment following lines to see the error_ \
        assertionFailure("A person's age can't be less than zero.")
    }
//: ### Enforcing Preconditions
//: Preconditions are userd whenever a condition has the potential to be false, but must _definitely_ be true for your code to continue execution. \
//: Write a precondition by calling the `precondition(_:_:file:line:`) function:
    // In the implementation of a subscript...
    let index = Int.min;
//: 🧨 _uncomment following lines to see the error_ \
//    precondition(index > 0, "Index must be greater than zero.")
//: Call the `preconditionFailure(_:file:line:`) function to indicate that a failure has occurred.
//: - - -
//: ✏️ When compiled in unchecked mode (`-Ounchecked`), preconditions aren’t checked. The compiler assumes that preconditions are always true, and it optimizes your code accordingly.
//: - - -
//: 🔧 Use the `fatalError(_:file:line:`) function during prototyping and early development to create stubs for functionality that hasn’t been implemented yet. `fatalError(_:file:line:`) function always halts execution, regardless of optimization settings.
//: - - -
//:
//: [Next →](@next)
