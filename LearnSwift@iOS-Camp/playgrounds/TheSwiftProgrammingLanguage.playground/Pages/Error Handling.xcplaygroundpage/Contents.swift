//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Error Handling
//: _Error handling_ is the process of responding to and recovering from error conditions in your program.
//:
//: Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime.
/*:
 - Note:
 Error handling in Swift interoperates with error handling patterns that use the `NSError` class in Cocoa and Objective-C.
 */
//: ## Representing and Throwing Errors
//: In Swift, errors are represented by values of types that conform to the `Error` protocol.
//:
//: This empty protocol indicates that a type can be used for error handling.
//:
//: Swift enumerations are particularly well suited to modeling a group of related error conditions:
    enum VendingMachineError: Error {
        case invalidSelection
        case insufficientFunds(coinsNeeded: Int)
        case outOfStock
    }
//: Throwing an error lets you indicate that something unexpected happened and the normal flow of execution can’t continue.
//: You use a `throw` statement to throw an error:
    import Foundation

    do {
        throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
    } catch {
        print(error)
    }
//: ## Handling Errors
//: When an error is thrown, some surrounding piece of code must be responsible for handling the error.
//:
//: There are four ways to handle errors in Swift:
//: - You can propagate the error from a function to the code that calls that function.
//: - Handle the error using a `do-catch` statement.
//: - Handle the error as an optional value.
//: - Or assert that the error will not occur.
//:
//: When a function throws an error, it changes the flow of your program, so it’s important that you can quickly identify places in your code that can throw errors.
//:
//: To identify these places in your code, write the `try` keyword—or the `try?` or `try!` variation—before a piece of code that calls a function, method, or initializer that can throw an error.
/*:
 - Note:
 Error handling in Swift resembles exception handling in other languages, with the use of the `try`, `catch` and `throw` keywords. Unlike exception handling in many languages—including Objective-C—error handling in Swift does not involve unwinding the call stack, a process that can be computationally expensive. As such, the performance characteristics of a `throw` statement are comparable to those of a `return` statement.
 */
//: ### Propagating Errors Using Throwing Functions
//: To indicate that a function, method, or initializer can throw an error, you write the `throws` keyword in the function’s declaration after its parameters.
//:
//: A function marked with `throws` is called a _throwing function_.
//:
//: If the function specifies a return type, you write the `throws` keyword before the return arrow (`->`).
/*:
 - Example:
 ```
 func canThrowErrors() throws -> String
 
 func cannotThrowErrors() -> String
 ```
 */
//: A throwing function propagates errors that are thrown inside of it to the scope from which it’s called.
/*:
 - Note:
 Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.
 */
    struct Item {
        var price: Int
        var count: Int
    }

    class VendingMachine {
        var inventory = [
            "Candy Bar": Item(price: 12, count: 7),
            "Chips": Item(price: 10, count: 4),
            "Pretzels": Item(price: 7, count: 11)
        ]
        
        var coinsDeposited = 0
        
        func vend(itemNamed name: String) throws {
            guard let item = inventory[name] else {
                throw VendingMachineError.invalidSelection
            }
            
            guard item.count > 0 else {
                throw VendingMachineError.outOfStock
            }
            
            guard item.price <= coinsDeposited else {
                throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
            }
            
            coinsDeposited -= item.price
            
            var newItem = item
            newItem.count -= 1
            inventory[name] = newItem
            
            print("Dispensing \(name)")
        }
    }

    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels",
    ]

    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }

    struct PurchasedSnack {
        let name: String
        
        init(name: String, vendingMachine: VendingMachine) throws {
            try vendingMachine.vend(itemNamed: name)
            self.name = name
        }
    }
//: ### Handling Errors Using Do-Catch
//: Here is the general form of a do-catch statement:
/*:
 - Example:
 ```
 do {
 try <#expression#>
    <#statements#>
 } catch #<pattern 1#> {
    <#statements#>
 } catch <#pattern 2#> where <#condition#> {
    <#statements#>
 } catch {
    <#statements#>
 }
 ```
 */
//: You write a pattern after `catch` to indicate what errors that clause can handle.
//:
//: If a `catch` clause doesn’t have a pattern, the clause matches any error and binds the error to a local constant named `error`.
//:
    var vendingMachine = VendingMachine()
    vendingMachine.coinsDeposited = 8

    do {
        try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
        print("Success! Yum.")
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.outOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    } catch {
        print("Unexpected error: \(error).")
    }
//: The catch clauses don’t have to handle every possible error that the code in the `do` clause can throw.
//:
//: If none of the `catch` clauses handle the error, the error propagates to the surrounding scope.
//:
//: However, the propagated error must be handled by _some_ surrounding scope. In a nonthrowing function, an enclosing `do-catch` clause must handle the error.
func nourish(with item: String) -> Int {
    return 0
}

    func nourish(with item: String) throws -> String {
        do {
            try vendingMachine.vend(itemNamed: item)
        } catch is VendingMachineError {
            print("Invalid selection, out of stock, or not enough money.")
        }
        return ""
    }

    do {
        try nourish(with: "Beet-Flavored Chips")
    } catch {
        print("Unexpected non-vending-machine-related error: \(error)")
    }
//: ### Converting Errors to Optional Values
//: You use `try?` to handle an error by converting it to an optional value.
/*:
 - Example:
 ```
 func someThrowingFunction() throws -> Int {
        // ...
 }
 
 let x = try? someThrowingFunction()
 
 let y: Int?
 do {
        y = try someThrowingFunction()
 } catch {
        y = nil
 }
 ```
 */
//: If `someThrowingFunction()` throws an error, the value of `x` and `y` is `nil`.
//:
//: Otherwise, the value of `x` and `y` is the value that the function returned.
//: Note that `x` and `y` are an optional of whatever type `someThrowingFunction()` returns.
//:
/*:
 - Example:
 ```
 func fetchData() -> Data? {
        if let data = try? fetchDataFromDisk() { return data }
        if let data = try? fetchDataFromServer() { return data }
 
        return nil
 }
 ```
 */
//: ### Disabling Error Propagation
//: Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime.
//:
//: On those occasions, you can write `try!` before the expression to disable error propagation and wrap the call in a runtime assertion that no error will be thrown.
//:
//: If an error actually is thrown, you’ll get a runtime error.
//:
//: In this case, because the image is shipped with the application, no error will be thrown at runtime, so it is appropriate to disable error propagation.
/*:
 - Example:
 ```
 let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
 ```
 */
//:
//: ## Specifying Cleanup Actions
//: Use a `defer` statement to execute a set of statements just before code execution leaves the current block of code.
//:
//: This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block of code—whether it leaves because an error was thrown or because of a statement such as `return` or `break`.
//:
//: For example, you can use a `defer` statement to ensure that file descriptors are closed and manually allocated memory is freed.
//:
//: The deferred statements may not contain any code that would transfer control out of the statements, such as a `break` or a `return` statement, or by throwing an error.
//:
//: Deferred actions are executed in the reverse of the order that they’re written in your source code.
//: That is, the code in the first `defer` statement executes last.

func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        
        defer {
            close(file)
        }
        
        while let line = try file.readline() {
            // Work with the file.
            print("Reading line: \(line.number)")
        }
        // close(file) is called here, at the end of the scope.
        
    }
}

try? processFile(filename: "blah.yaml")
/*:
 - Note:
 You can use a `defer` statement even when no error handling code is involved.
 */
//: 
//: [Next →](@next)
