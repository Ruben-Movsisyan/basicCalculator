//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//: # Deinitialization
//: A _deinitializer_ is called immediately before a class instance is deallocated.
//:
//: You write deinitializers with the `deinit` keyword, similar to how initializers are written with the `init` keyword.
//:
//: Deinitializers are only available on class types.
//: ## How Deinitialization Works
//: Swift automatically deallocates your instances when they are no longer needed, to free up resources.
//:
//: Swift handles the memory management of instances through _automatic reference counting (ARC)_.
//:
//: Typically you don’t need to perform manual cleanup when your instances are deallocated. However, when you are working with your own resources, you might need to perform some additional cleanup yourself.
//:
//: Class definitions can have at most one deinitializer per class.
//:
//: The deinitializer does not take any parameters and is written without parentheses:
/*:
 - Example:
 ```
 deinit {
    // perform the deinitialization
 }
 ```
 */
//: Deinitializers are called automatically, just before instance deallocation takes place.
//:
//: You are not allowed to call a deinitializer yourself.
//:
//: Superclass deinitializers are inherited by their subclasses, and the superclass deinitializer is called automatically at the end.
//:
//: Because an instance is not deallocated until after its deinitializer is called, a deinitializer can access all properties of the instance it is called on and can modify its behavior based on those properties (such as looking up the name of a file that needs to be closed).
//: ## Deinitializers in Action
//: Here’s an example of a deinitializer in action:
    class Bank {
        static var coinsInBank = 10_000
        
        static func distribute(coins numberOfCoinsRequested: Int) -> Int {
            let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
            coinsInBank -= numberOfCoinsToVend
            return numberOfCoinsToVend
        }
        
        static func receive(coins: Int) {
            coinsInBank += coins
        }
    }
//:
    class Player {
        var coinsInPurse: Int
        
        init(coins: Int) {
            coinsInPurse = Bank.distribute(coins: coins)
        }
        
        func win(coins: Int) {
            coinsInPurse += Bank.distribute(coins: coins)
        }
        
        deinit {
            Bank.receive(coins: coinsInPurse)
        }
    }
//:
    var playerOne: Player? = Player(coins: 100)

    print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")

    print("There are now \(Bank.coinsInBank) coins left in the bank")
//:
    playerOne!.win(coins: 2_000)

    print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")

    print("The bank now only has \(Bank.coinsInBank) coins left")
//:
    playerOne = nil

    print("PlayerOne has left the game")

    print("The bank now has \(Bank.coinsInBank) coins")
//:
//: [Next →](@next)
