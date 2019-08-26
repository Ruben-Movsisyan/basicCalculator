//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Collection Types
//: Swift provides three primary _collection types_:
//: * **Arrays** are ordered collections of values.
//: * **Sets** are unordered collections of unique values.
//: * **Dictionaries** are unordered collections of key-value associations.
//:
//: Arrays, sets, and dictionaries in Swift are always clear about the types of values and keys that they can store.
//:
//: - - -
//: ✏️ Swift’s array, set, and dictionary types are implemented as _generic collections_.
//: - - -
//: ## Mutability of Collections
//: Collections are _mutable_ when declared with `var` and _immutable_ when declared with `let`.
//: - - -
//: ✏️ Always create immutable collections if you're not going to change them later.
//: - - -
//: ## Arrays
//: An _array_ stores values of the same type in an ordered list.
//: The same value can appear in an array multiple times at different positions.
//: - - -
//: ✏️ Swift’s `Array` type is bridged to Foundation’s `NSArray` class.
//: - - -
//: ### Array Type Shorthand Syntax
//: The type of a Swift array is written in full as `Array<Element>`, where `Element` is the type of values the array is allowed to store. You can also write the type of an array in shorthand form as `[Element]`.
//:
//: The shorthand form is preferred.
//: ### Creating an Empty Array
//: Initializer syntax:
    var someInts = [Int]()

    print("someInts is of type [Int] with \(someInts.count) items.")
//: If the context already provides type information, such as a function argument or an already typed variable or constant, you can create an empty array with an empty array literal, which is written as `[]`:
    someInts.append(3)

    someInts = []
//: ### Creating an Array with a Default Value
    var threeDoubles = Array(repeating: 0.0, count: 3)

    type(of: threeDoubles)
//: ### Creating an Array by Adding Two Arrays Together
    var anotherThreeDoubles = Array(repeating: 2.5, count: 3)

    var sixDoubles = threeDoubles + anotherThreeDoubles

//: ### Creating an Array with Array Literal
//: An array literal is written as a list of values, separated by commas, surrounded by a pair of square brackets: `[value 1, value 2, value 3]`:
    var shoppingList: [String] = ["Eggs", "Milk"]
//: The `shoppingList` variable is declared as “an array of string values”, written as `[String]`. Because this particular array has specified a value type of `String`, it is allowed to store `String` values only.
//:
//: The initialization of `shoppingList` could have been written in a shorter form instead:
//    var shoppingList = ["Eggs", "Milk"]
//: ### Accessing and Modifying an Array
//: To find out the number of items in an array, check its read-only `count` property:
    print("The shopping list contains \(shoppingList.count) items.")
//: Use the Boolean `isEmpty` property as a shortcut for checking whether the `count` property is equal to 0:
    if shoppingList.isEmpty {
        print("The shopping list is empty.")
    } else {
        print("The shopping list is not empty.")
    }
//: Add a new item to the end of an array by calling the array’s `append(_:)` method:
    shoppingList.append("Flour")
//: Append an array of one or more compatible items with the addition assignment operator `(+=)`:
    shoppingList += ["Baking Powder"]

    shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
//: Retrieve a value from the array by using _subscript syntax_:
    var firstItem = shoppingList[0]
//: - - -
//: ✏️ The first item in the array has an index of 0, not 1. Arrays in Swift are always zero-indexed.
//: - - -
//: Use subscript syntax to change an existing value at a given index:
    shoppingList[0] = "Six eggs"
//: When you use subscript syntax, the index you specify needs to be valid. For example, writing `shoppingList[shoppingList.count] = "Salt"` to try to append an item to the end of the array results in a runtime error.
//:
//: Use subscript syntax to change a range of values at once, even if the replacement set of values has a different length than the range you are replacing:
    shoppingList

    shoppingList[4...6] = ["Bananas", "Apples"]

    shoppingList
//: To insert an item into the array at a specified index, call the array’s `insert(_:at:)` method:
    shoppingList.insert("Maple Syrup", at: 0)
//: Remove an item from the array with the `remove(at:)` method.
//:
//: This method removes the item at the specified index and returns the removed item:
    let mapleSyrup = shoppingList.remove(at: 0)
//: - - -
//: ✏️ If you try to access or modify a value for an index that is outside of an array’s existing bounds, you will trigger a runtime error. You can check that an index is valid before using it by comparing it to the array’s `count` property. The largest valid index in an array is `count - 1` because arrays are indexed from zero—however, when count is 0 (meaning the array is empty), there are no valid indexes.
//: - - -
//: Any gaps in an array are closed when an item is removed, and so the value at index 0 is once again equal to `"Six eggs"`:
    firstItem = shoppingList[0]
//: Remove the final item from an array, use the `removeLast()` method rather than the `remove(at:)` method to avoid the need to query the array’s `count` property. Like the `remove(at:)` method, `removeLast()` returns the removed item:
    let apples = shoppingList.removeLast()
//: ### Iterating Over an Array
    for item in shoppingList {
        print(item)
    }

    for (index, value) in shoppingList.enumerated() {
        print("Item \(index + 1): \(value)")
    }
//: ## Sets
//: A _set_ stores distinct values of the same type in a collection with no defined ordering.
//: - - -
//: ✏️ Swift’s `Set` type is bridged to Foundation’s `NSSet` class.
//: - - -
//: ### Hash Values for Set Types
//: A type must be _hashable_ in order to be stored in a set—that is, the type must provide a way to compute a _hash value_ for itself.
//: A hash value is an `Int` value that is the same for all objects that compare equally, such that if `a == b`, it follows that `a.hashValue == b.hashValue`.
//:
//: All of Swift’s basic types (such as `String`, `Int`, `Double`, and `Bool`) are hashable by default, and can be used as set value types or dictionary key types. Enumeration case values without associated values (as described in Enumeration) are also hashable by default.
//:
//: 🔧 You can use your own custom types as set value types or dictionary key types by making them conform to the `Hashable` protocol from Swift’s standard library. Types that conform to the `Hashable` protocol must provide a gettable `Int` property called `hashValue`. The value returned by a type’s `hashValue` property is not required to be the same across different executions of the same program, or in different programs.
//: - - -
//: ✏️ Because the `Hashable` protocol conforms to `Equatable`, conforming types must also provide an implementation of the equals operator (`==`). The `Equatable` protocol requires any conforming implementation of `==` to be an equivalence relation. That is, an implementation of `==` must satisfy the following three conditions, for all values `a`, `b`, and `c`:
//: * `a == a` (Reflexivity)
//: * `a == b` implies `b == a` (Symmetry)
//: * `a == b && b == c` implies `a == c` (Transitivity)
//: - - -
//: ### Set Type Syntax
//: The type of a Swift set is written as `Set<Element>`, where `Element` is the type that the set is allowed to store.
//: - - -
//: ✏️ Unlike arrays, sets do not have an equivalent shorthand form.
//: - - -
//: ### Creating and Initializing an Empty Set
//: Create an empty set of a certain type using initializer syntax:
    var letters = Set<Character>()

    print("letters is of type Set<Character> with \(letters.count) items.")
//: - - -
//: ✏️ The type of the letters variable is inferred to be `Set<Character>`, from the type of the initializer.
//: - - -
//: If the context already provides type information you can create an empty set with an empty array literal:
    letters.insert("a")

    letters = []
//: ### Creating a Set with an Array Literal
//: Initialize a set with an array literal, as a shorthand way to write one or more values as a set collection:
    var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
//: - - -
//: ✏️ The `favoriteGenres` variable is declared as “a set of String values”, written as `Set<String>`. Because this particular set has specified a value type of `String`, it is only allowed to store `String` values.
//: - - -
//: ✏️ A set type cannot be inferred from an array literal alone, so the type `Set` must be explicitly declared.
//: - - -
//: However, because of Swift’s type inference, you don’t have to write the type of the set’s elements if you’re initializing it with an array literal that contains values of just one type.
//:
//: The initialization of `favoriteGenres` could have been written in a shorter form instead:
//    var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
//: ### Accessing and Modifying a Set
//: To find out the number of items in a set, check its read-only `count` property:
    print("I have \(favoriteGenres.count) favorite music genres.")
//: Use the Boolean `isEmpty` property as a shortcut for checking whether the count property is equal to `0`:
    if favoriteGenres.isEmpty {
        print("As far as music goes, I'm not picky.")
    } else {
        print("I have particular music preferences.")
    }
//: Add a new item into a set by calling the set’s `insert(_:)` method:
    favoriteGenres.insert("Jazz")
//: You can remove an item from a set by calling the set’s `remove(_:)` method, which removes the item if it’s a member of the set, and returns the removed value, or returns `nil` if the set did not contain it.
//:
//: Alternatively, all items in a set can be removed with its `removeAll()` method.
    if let removedGenre = favoriteGenres.remove("Rock") {
        print("\(removedGenre)? I'm over it.")
    } else {
        print("I never much cared for that.")
    }
//: To check whether a set contains a particular item, use the `contains(_:)` method.
    if favoriteGenres.contains("Funk") {
        print("I get up on the good foot.")
    } else {
        print("It's too funky in here.")
    }
//: ### Iterating Over a Set
    for genre in favoriteGenres {
        print("\(genre)")
    }
//: Swift’s `Set` type does not have a defined ordering. To iterate over the values of a set in a specific order, use the `sorted()` method, which returns the set’s elements as an array sorted using the `<` operator:
    for genre in favoriteGenres.sorted() {
        print("\(genre)")
    }
//: ## Performing Set Operatiions
//: You can efficiently perform fundamental set operations, such as combining two sets together, determining which values two sets have in common, or determining whether two sets contain all, some, or none of the same values.
//: ### Fundamental Set Operations
//:
//: * Use the `intersection(_:)` method to create a new set with only the values common to both sets.
//: * Use the `symmetricDifference(_:)` method to create a new set with values in either set, but not both.
//: * Use the `union(_:)` method to create a new set with all of the values in both sets.
//: * Use the `subtracting(_:)` method to create a new set with values not in the specified set.
//: ![SetVennDiagram](setVennDiagram_2x.png "Fundamental Set Operations")
//:
    let oddDigits: Set = [1, 3, 5, 7, 9]

    let evenDigits: Set = [0, 2, 4, 6, 8]

    let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

    oddDigits.union(evenDigits).sorted()

    oddDigits.intersection(evenDigits).sorted()

    oddDigits.subtracting(singleDigitPrimeNumbers).sorted()

    oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
//: ### Set Membership and Equality
//: * Set `a` is a _superset_ of set `b`, because a contains all elements in `b`.
//: * Set `b` is a _subset_ of set `a`, because all elements in `b` are also contained by `a`.
//: * Set `b` and set `c` are _disjoint_ with one another, because they share no elements in common.
//:
//: ![SetEulerDiagram](setEulerDiagram_2x.png "Set Membership and Equality")
//:
//: * Use the “is equal” operator (`==`) to determine whether two sets contain all of the same values.
//: * Use the `isSubset(of:)` method to determine whether all of the values of a set are contained in the specified set.
//: * Use the `isSuperset(of:)` method to determine whether a set contains all of the values in a specified set.
//: * Use the `isStrictSubset(of:)` or `isStrictSuperset(of:)` methods to determine whether a set is a subset or superset, but not equal to, a specified set.
//: * Use the `isDisjoint(with:)` method to determine whether two sets have no values in common:
    let houseAnimals: Set = ["🐶", "🐱"]

    let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]

    let cityAnimals: Set = ["🐦", "🐭"]

    houseAnimals.isSubset(of: farmAnimals)

    farmAnimals.isSuperset(of: houseAnimals)

    farmAnimals.isDisjoint(with: cityAnimals)
//: ## Dictionaries
//: A _dictionary_ stores associations between _keys_ of the same type and _values_ of the same type in a collection with no defined ordering.
//:
//: Each value is associated with a unique _key_.
//: - - -
//: ✏️ Swift’s `Dictionary` type is bridged to Foundation’s `NSDictionary` class.
//: - - -
//: ### Dictionary Type Shorthand Syntax
//: The type of a Swift dictionary is written in full as `Dictionary<Key, Value>`, where `Key` is the type of value that can be used as a dictionary key, and `Value` is the type of value that the dictionary stores for those keys.
//: - - -
//: ✏️ A dictionary `Key` type must conform to the `Hashable` protocol, like a set’s value type.
//: - - -
//: You can also write the type of a dictionary in shorthand form as `[Key: Value]`. Although the two forms are functionally identical, the shorthand form is preferred.
//: ### Creating an Empty Dictionary
//: Create an empty `Dictionary` of a certain type by using initializer syntax:
    var namesOfIntegers = [Int: String]()
//: If the context already provides type information, you can create an empty dictionary with an empty dictionary literal, which is written as `[:]`:
    namesOfIntegers[16] = "sixteen"

    namesOfIntegers = [:]
//: ### Creating a Dictionary with a Dictionary Literal
//: Initialize a dictionary with a dictionary literal.
//: A _key-value pair_ is a combination of a key and a value. In a dictionary literal, the key and value in each key-value pair are separated by a colon.
//: The key-value pairs are written as a list, separated by commas, surrounded by a pair of square brackets: `[key 1: value 1, key 2: value 2, key 3: value 3]`
    var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
//: Shorter form for dictionary initialization:
//    var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

//: The airports dictionary is declared as having a type of `[String: String]`, which means “a Dictionary whose keys are of type `String`, and whose values are also of type `String`”.
//: ### Accessing and Modifying a Dicitonary
//: Find out the number of items in a `Dictionary` by checking its read-only `count` property:
    print("The airports dictionary contains \(airports.count) items.")

//: Use the Boolean `isEmpty` property as a shortcut for checking whether the `count` property is equal to `0`:
    if airports.isEmpty {
        print("The airports dictionary is empty.")
    } else {
        print("The airports dictionary is not empty.")
    }
//: Add a new item to a dictionary with subscript syntax. Use a new key of the appropriate type as the subscript index, and assign a new value of the appropriate type:
    airports["LHR"] = "London"
//: Also use subscript syntax to change the value associated with a particular key:
    airports["LHR"] = "London Heathrow"
//: - - -
//: ✏️ As an alternative to subscripting, use a dictionary’s `updateValue(_:forKey:)` method to set or update the value for a particular key. The `updateValue(_:forKey:)` method sets a value for a key if none exists, or updates the value if that key already exists.
//: - - -
//: The `updateValue(_:forKey:)` method returns the old value after performing an update. This enables you to check whether or not an update took place.
//:
//: The `updateValue(_:forKey:)` method returns an optional value of the dictionary’s value type:
    if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
        print("The old value for DUB was \(oldValue).")
    }
//: Use subscript syntax to retrieve a value from the dictionary for a particular key. A dictionary’s subscript returns an optional value of the dictionary’s value type:
    if let airportName = airports["DUB"] {
        print("The name of the airport is \(airportName).")
    } else {
        print("That airport is not in the airports dictionary.")
    }
//: You can use subscript syntax to remove a key-value pair from a dictionary by assigning a value of nil for that key:
    airports["APL"] = "Apple International"

    airports["APL"] = nil
//: Remove a key-value pair from a dictionary with the `removeValue(forKey:)` method. This method removes the key-value pair if it exists and returns the removed value, or returns nil if no value existed:
    if let removedValue = airports.removeValue(forKey: "DUB") {
        print("The removed airport's name is \(removedValue).")
    } else {
        print("The airports dictionary does not contain a value for DUB.")
    }
//: Iterate over the key-value pairs in a dictionary with a `for-in` loop. Each item in the dictionary is returned as a `(key, value)` tuple, and you can decompose the tuple’s members into temporary constants or variables as part of the iteration:
    for (airportCode, airportName) in airports {
        print("\(airportCode): \(airportName)")
    }
//: You can also retrieve an iterable collection of a dictionary’s keys or values by accessing its `keys` and `values` properties:
    for airportCode in airports.keys {
        print("Airport code: \(airportCode)")
    }

    for airportName in airports.values {
        print("Airport name: \(airportName)")
    }
//: If you need to use a dictionary’s keys or values with an API that takes an Array instance, initialize a new array with the `keys` or `values` property:
    let airportCodes = [String](airports.keys)

    let airportNames = [String](airports.values)
//:
//: - - -
//: 🔧 Swift’s `Dictionary` type does not have a defined ordering. To iterate over the keys or values of a dictionary in a specific order, use the `sorted()` method on its keys or values property. (see also:  [KeyValuePairs](https://developer.apple.com/documentation/swift/keyvaluepairs))
//: - - -
//:
//: [Next →](@next)
