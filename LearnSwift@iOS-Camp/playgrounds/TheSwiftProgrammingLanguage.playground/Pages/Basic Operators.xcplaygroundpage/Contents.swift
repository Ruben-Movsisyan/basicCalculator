//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Basic Operators
//: An operator is a special symbol or phrase that you use to check, change, or combine values.
//: * The assignment operator (`=`) doesn’t return a value.
//: * Arithmetic operators (`+, -, *, /, %` and so forth) detect and disallow value overflow.
//: * Swift also provides range operators.
//: ## Terminology
//: Operators are _unary, binary, or ternary_:
//: * **Unary** operators operate on a single target (such as `-a`).
//:     _Unary prefix_ operators appear immediately before their target (such as `!b`),
//:     _Unary postfix_ operators appear immediately after their target (such as `c!`).
//: * **Binary** operators operate on two targets (such as `2 + 3`) and are _infix_ because they appear in between their two targets.
//: * **Ternary** operators operate on three targets. Like C, Swift has only one ternary operator, the _ternary conditional operator_ (`a ? b : c`). \
//: The values that operators affect are _operands_.
//: ## Assignment Operator
//: The assignment operator (`a = b`) initializes or updates the value of `a` with the value of `b`:
    let b = 10

    var a = 5

    a = b
//: - - -
//: ✏️ Unlike the assignment operator in C and Objective-C, the _assignment operator_ in Swift does not itself return a value.
//: - - -
//: The following statement is not valid: \
//: 🧨 _uncomment following lines to see the error_
//    if a = b {
//        // This is not valid, because a = b does not return a value.
//    }
//: ## Arithmetic Operators
//: Swift supports the four standard arithmetic operators for all number types:
//: * Addition (`+`)
//: * Subtraction (`-`)
//: * Multiplication (`*`)
//: * Division (`/`)
//: - - -
//: ✏️ Unlike the arithmetic operators in C and Objective-C, the Swift arithmetic operators don’t allow values to overflow by default.
//: - - -
//: - - -
//: 🔧 You can opt in to value overflow behavior by using Swift’s overflow operators (such as `a &+ b`).
//: - - -
//: ### Reminder
//: The remainder operator (`a % b`) works out how many multiples of b will fit inside a and returns the value that is left over (known as the _remainder_).
//: - - -
//: ✏️ The remainder operator (`%`) is also known as a _modulo operator_ in other languages. However, its behavior in Swift for negative numbers means that, strictly speaking, it’s a remainder rather than a modulo operation.
//: - - -
//: Here's how the remainder operator behaves:
    +9 % 4

    -9 % 4
//: ### Unary Minus Operator
//: The sign of a numeric value can be toggled using a prefixed `-`, known as the _unary minus operator_:
    let three = 3

    let minusThree = -three       // minusThree equals -3

    let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
//: ### Unary Plus Operator
//: The _unary plus operator_ (`+`) simply returns the value it operates on, without any change:
    let minusSix = -6

    let alsoMinusSix = +minusSix
//: - - -
//: ✏️ Although the unary plus operator doesn’t actually do anything, you can use it to provide symmetry in your code for positive numbers when also using the unary minus operator for negative numbers.
//: - - -
//: ## Compound Assignment Operators
//: Combine assignment (`=`) with another operation, like the _addition assignment operator_ (`+=`):
    var c = 1

    c += 2
//: This is shorthand for `c = c + 2`.
//: - - -
//: ✏️ The compound assignment operators don’t return a value. For example, you can’t write `let b = a += 2`.
//: - - -
//: ## Comparison Operators
//: Swift supports all standard C comparison operators:
//: * Equal to (`a == b`)
//: * Not equal to (`a != b`)
//: * Greater than (`a > b`)
//: * Less than (`a < b`)
//: * Greater than or equal to (`a >= b`)
//: * Less than or equal to (`a <= b`) \
//: Each of the comparison operators returns a `Bool` value to indicate whether or not the statement is true:
    1 == 1

    2 != 1

    2 > 1

    1 < 2

    1 >= 1

    2 <= 1
//: - - -
//: ✏️ Swift also provides two identity operators (`===` and `!==`), which you use to test whether two object references both refer to the same object instance.
//: - - -
//: Compare two tuples if they have the same type and the same number of values. Tuples are compared from left to right, one value at a time:
    (1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared

    (3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"

    (4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
//: Tuples of type `(String, Bool)` can’t be compared with the `<` operator because the `<` operator can’t be applied to `Bool` values:
    ("blue", -1) < ("purple", 1)        // OK, evaluates to true
//: 🧨 _uncomment following lines to see the error_
   // ("blue", false) > ("purple", true)  // Error because < can't compare Boolean values
//: - - -
//: ✏️ The Swift standard library includes tuple comparison operators for tuples with _fewer than seven elements_. To compare tuples with seven or more elements, you must implement the comparison operators yourself.
//: - - -
//: ## Ternary Conditional Operator
//: Is a special operator with three parts, which takes the form `question ? answer1 : answer2`. \
//: The ternary conditional operator is shorthand for the code below: \
//:     if question {
//:         answer1
//:     } else {
//:         answer2
//:     } \
//: Here’s an example, which calculates the height for a table row:
    let contentHeight = 40

    let hasHeader = true

    let rowHeight = contentHeight + (hasHeader ? 50 : 20)
//: ## Nil-Coalescing Operator
//: The _nil-coalescing operator_ (`a ?? b`) unwraps an optional `a` if it contains a value, or returns a default value `b` if `a` is `nil`:
    var iceCream: String?

    let juice = "🥤"

    iceCream != nil ? iceCream! : juice

    iceCream ?? juice
//: - - -
//: ✏️ If the value of `a` is non-`nil`, the value of `b` is not evaluated. This is known as _short-circuit evaluation_.
//: - - -
//: ## Range Operators
//: Swift includes several range operators, which are shortcuts for expressing a range of values.
//: ### Closed Range Operator
//: The _closed range operator_ (`a...b`) defines a range that runs from `a` to `b`, and includes the values `a` and `b`. \
//: The value of `a` must not be greater than `b`.
//: Closed range operator's useful to iterate over with `for-in` loops:
    for index in 1...5 {
        print("\(index) times 5 is \(index * 5)")
    }
//: ### Half-Open Range Operator
//: The _half-open range operator_ (`a..<b`) defines a range that runs from `a` to `b`, but doesn’t include `b`. It’s said to be half-open because it contains its first value, but not its final value. \
//: If the value of `a` is equal to `b`, then the resulting range will be empty. \
//: Half-open ranges are particularly useful when you work with _zero-based_ lists such as arrays:
    let names = ["Anna", "Alex", "Brian", "Jack"]

    let count = names.count

    for i in 0..<count {
        print("Person \(i + 1) is called \(names[i])")
    }
//: ### One-Sided Ranges
//: One-sided range operator has a value on only one side:
    for name in names[2...] {
        print(name)
    }

    for name in names[...2] {
        print(name)
    }

    for name in names[..<2] {
        print(name)
    }
//: - - -
//: ✏️ You can’t iterate over a one-sided range that omits a first value, because it isn’t clear where iteration should begin.
//: - - -
//: You can iterate over a one-sided range that omits its final value. \
//: Check whether a one-sided range contains a particular value:
    let range = ...5

    type(of: range)

    range.contains(7)

    range.contains(4)

    range.contains(-1)

    range.contains(Int.min)
//: ## Logical Operators
//: Swift supports the three standard logical operators found in C-based languages:
//: * Logical NOT (`!a`)
//: * Logical AND (`a && b`)
//: * Logical OR (`a || b`)
//: ### Logical NOT Operator
//: The logical NOT operator (`!a`) inverts a Boolean value so that `true` becomes `false`, and `false` becomes `true`.
    let allowedEntry = false

    if !allowedEntry {
        print("ACCESS DENIED")
    }
//: ### Logical AND Operator
//: The logical AND operator (`a && b`) creates logical expressions where both values must be `true` for the overall expression to also be `true`:
    let enteredDoorCode = true

    let passedRetinaScan = false

    if enteredDoorCode && passedRetinaScan {
        print("Welcome!")
    } else {
        print("ACCESS DENIED")
    }
//: ### Logical OR Operator
//: The logical OR operator (`a || b`) is an infix operator made from two adjacent pipe characters. Use it to create logical expressions in which only one of the two values has to be `true` for the overall expression to be `true`:
    let hasDoorKey = false

    let knowsOverridePassword = true

    if hasDoorKey || knowsOverridePassword {
        print("Welcome!")
    } else {
        print("ACCESS DENIED")
    }
//: - - -
//: ✏️ Like the Logical AND operator, the Logical OR operator uses _short-circuit evaluation_ to consider its expressions. If the left side of a Logical OR expression is `true`, the right side is not evaluated, because it can’t change the outcome of the overall expression.
//: - - -
//: ### Combining Logical Operators
//: Combine multiple logical operators to create longer compound expressions:
    if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
        print("Welcome!")
    } else {
        print("ACCESS DENIED")
    }
//: ### Explicit Parentheses
//: It’s useful to add parentheses around the first part of the compound expression to make its intent explicit:
    if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
        print("Welcome!")
    } else {
        print("ACCESS DENIED")
    }
//: - - -
//: ✏️ _Readability is always preferred over brevity_; use parentheses where they help to make your intentions clear and result in a more readable code.
//: - - -
//:
//: [Next →](@next)
