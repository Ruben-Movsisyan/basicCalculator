//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//: # Enumerations
//: An _enumeration_ defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code. \
//: If you are familiar with C, you will know that C enumerations assign related names to a set of integer values. \
//: In Swift, enumerations don’t have to provide a value for each case of the enumeration. If a value (known as a _raw value_) is provided for each enumeration case, the value can be a string, a character, or a value of any integer or floating-point type. \
//: Enumeration cases can specify _associated values_ of any type to be stored along with each different case value, much as _unions_ or _variants_ do in other languages. \
//: Enumerations in Swift are first-class types in their own right. They adopt many features traditionally supported only by classes, such as computed properties to provide additional information about the enumeration’s current value, and instance methods to provide functionality related to the values the enumeration represents. \
//: Enumerations can:
//: * Be extended to expand their functionality beyond their original implementation.
//: * Define initializers to provide an initial case value
//: * Conform to protocols to provide standard functionality.
//: ## Enumeration Syntax
//: You introduce enumerations with the `enum` keyword and place their entire definition within a pair of braces:
    enum SomeEnumeration {
        // enumeration definition goes here
    }
//: Here’s an example for the four main points of a compass:
    enum CompassPoint {
        case north
        case south
        case east
        case west
    }
//: The values defined in an enumeration (such as `north`, `south`, `east`, and `west`) are its _enumeration cases_. \
//: Use the `case` keyword to introduce new enumeration cases.
//: - - -
//: ✏️ Swift enumeration cases don’t have an integer value set by default, unlike languages like C and Objective-C.
//: - - -
//: Multiple cases can appear on a single line, separated by commas:
    enum Planet {
        case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
    }
//: - - -
//: ✏️ Each enumeration definition defines a new type. Like other types in Swift, their names (such as `CompassPoint` and `Planet`) start with a capital letter. \
//: Give enumeration types singular rather than plural names, so that they read as self-evident.
//: - - -
//: Once `directionToHead` is declared as a `CompassPoint`, you can set it to a different `CompassPoint` value using a shorter dot syntax:
    var directionToHead = CompassPoint.west

    directionToHead = .east
//: - - -
//: ✏️ The type of `directionToHead` is already known, and so you can drop the type when setting its value. \
//: This makes for highly readable code when working with explicitly typed enumeration values.
//: - - -
//: ## Matching Enumeration Values with a Switch Statement
//: Match individual enumeration values with a `switch` statement:
    directionToHead = .south

    switch directionToHead {
    case .north:
        print("Lots of planets have a north")
    case .south:
        print("Watch out for penguins")
    case .east:
        print("Where the sun rises")
    case .west:
        print("Where the skies are blue")
    }
//: - - -
//: ✏️ A `switch` statement must be exhaustive when considering an enumeration’s cases. \
//: Requiring exhaustiveness ensures that enumeration cases aren’t accidentally omitted.
//: - - -
//: When it isn’t appropriate to provide a `case` for every enumeration case, you can provide a `default` case to cover any cases that aren’t addressed explicitly:
    let somePlanet = Planet.earth
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
//: ## Iterating over Enumeration Cases
//: For some enumerations, it’s useful to have a collection of all of that enumeration’s cases. \
//: Enable this by writing : `CaseIterable` after the enumeration’s name. Swift exposes a collection of all the cases as an `allCases` property of the enumeration type.
    enum Beverage: CaseIterable {
        case coffee, tea, juice
    }

    let numberOfChoices = Beverage.allCases.count
    print("\(numberOfChoices) beverages available")

    for beverage in Beverage.allCases {
        print(beverage)
    }
//: ## Associated Values
//: It’s sometimes useful to be able to store values of other types alongside these case values. \
//: This additional information is called an _associated value_, and it varies each time you use that case as a value in your code. \
//: The value types can be different for each case of the enumeration if needed
//: - - -
//: ✏️ Enumerations similar to these are known as _discriminated unions_, _tagged unions_, or _variants_ in other programming languages.
//: - - -
//: Suppose an inventory tracking system needs to track products by two different types of barcode.
//: Some products are labeled with 1D barcodes in UPC format, which uses the numbers `0` to `9`. \
//: Each barcode has a number system digit, followed by five manufacturer code digits and five product code digits. These are followed by a check digit to verify that the code has been scanned correctly: \
//: ![Barcode UPC](barcode_UPC_2x.png) \
//: Other products are labeled with 2D barcodes in QR code format, which can use any ISO 8859-1 character and can encode a string up to 2,953 characters long: \
//: ![Barcode QR](barcode_QR_2x.png) \
//: An enumeration to define product barcodes of either type might look like this:
    enum Barcode {
        case upc(Int, Int, Int, Int)
        case qrCode(String)
    }
//: - - -
//: ✏️ This definition doesn’t provide any actual `Int` or `String` values—it just defines the _type_ of _associated values_ that `Barcode` constants and variables can store when they are equal to `Barcode.upc` or `Barcode.qrCode`.
//: - - -
//: Create new barcodes using either type:
    var productBarcode = Barcode.upc(8, 85909, 51226, 3)
//: Assign the same product a different type of barcode:
    productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
//: extract each associated value as a constant (with the let prefix) or a variable (with the var prefix) for use within the switch case’s body:
    switch productBarcode {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let productCode):
        print("QR code: \(productCode).")
    }
//: Place a single `var` or `let` annotation before the case name, for brevity:
    switch productBarcode {
    case let .upc(numberSystem, manufacturer, product, check):
        print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
    case let .qrCode(productCode):
        print("QR code: \(productCode).")
    }
//: ## Raw Values
//: Enumeration cases can come prepopulated with default values (called _raw values_), which are all of the same type. \
//: An example that stores raw ASCII values alongside named enumeration cases:
    enum ASCIIControlCharacter: Character {
        case tab = "\t"
        case lineFeed = "\n"
        case carriageReturn = "\r"
    }
//: Raw values can be strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.
//: - - -
//: ✏️ Raw values are not the same as associated values. \
//: Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. \
//: Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so.
//: - - -
//: ### Implicitly Assigned Raw Values
//: When you’re working with enumerations that store integer or string raw values, you don’t have to explicitly assign a raw value for each case. When you don’t, Swift automatically assigns the values for you. \
//: When integers are used for raw values, the implicit value for each case is one more than the previous case. If the first case doesn’t have a value set, its value is `0`.
    enum IntRepresentablePlanet: Int {
        case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    }
//: In the example above, `Planet.mercury` has an explicit raw value of `1`, `Planet.venus` has an implicit raw value of `2`, and so on. \
//: When strings are used for raw values, the implicit value for each case is the text of that case’s name.
    enum StringRepresentableCompassPoint: String {
        case north, south, east, west
    }
//: In the example above, `CompassPoint.south` has an implicit raw value of "south", and so on. \
//: Access the raw value of an enumeration case with its `rawValue` property:
    let earthsOrder = IntRepresentablePlanet.earth.rawValue

    let sunsetDirection = StringRepresentableCompassPoint.west.rawValue
//: ### Initializing from a Raw Value
//: If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called `rawValue`) and returns either an enumeration case or `nil`.
    let possiblePlanet = IntRepresentablePlanet(rawValue: 7)

    type(of: possiblePlanet)
//: Not all possible `Int` values will find a matching planet.
//: So the raw value initializer always returns an `optional` enumeration case. \
//: In the example above, `possiblePlanet` is of type `IntRepresentablePlanet?`.
    let positionToFind = 11
        if let somePlanet = IntRepresentablePlanet(rawValue: positionToFind) {
        switch somePlanet {
        case .earth:
            print("Mostly harmless")
        default:
            print("Not a safe place for humans")
        }
    } else {
        print("There isn't a planet at position \(positionToFind)")
    }
//: ## Recursive Enumerations
//: A _recursive enumeration_ is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. \
//: You indicate that an enumeration case is recursive by writing `indirect` before it, which tells the compiler to insert the necessary layer of indirection. \
//: For example, here is an enumeration that stores simple arithmetic expressions:
//    enum ArithmeticExpression {
//        case number(Int)
//        indirect case addition(ArithmeticExpression, ArithmeticExpression)
//        indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
//    }
//: Write `indirect` before the beginning of the enumeration to enable indirection for all of the enumeration’s cases that have an associated value:
    indirect enum ArithmeticExpression {
        case number(Int)
        case addition(ArithmeticExpression, ArithmeticExpression)
        case multiplication(ArithmeticExpression, ArithmeticExpression)
    }
//: The code below shows the `ArithmeticExpression` recursive enumeration being created for `(5 + 4) * 2`:
    let five = ArithmeticExpression.number(5)
    let four = ArithmeticExpression.number(4)
    let sum = ArithmeticExpression.addition(five, four)
    let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

//: A function that evaluates an arithmetic expression:
    func evaluate(_ expression: ArithmeticExpression) -> Int {
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
        }
    }

    print(evaluate(product))
//:
//: [Next →](@next)
