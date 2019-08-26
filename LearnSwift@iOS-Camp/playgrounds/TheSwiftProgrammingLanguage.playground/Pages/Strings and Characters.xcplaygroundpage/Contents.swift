		    let someString = "Some string literal value"
//: ### Multiline String Literals
//: If you need a string that spans several lines, use a multiline string literal:
    let quotation = """
    The White Rabbit put on his spectacles.  "Where shall I begin,
    please your Majesty?" he asked.

    "Begin at the beginning," the King said gravely, "and go on
    till you come to the end; then stop.
    """
//: The string begins on the first line after the opening quotation marks (`"""`) and ends on the line before the closing quotation marks, which means that neither of the strings below start or end with a line break:
    let singleLineString = "These are the same."

    let multilineString = """
    These are the same.
"""		
//: Line breaks in source code appear in the string's value, write a backslash (`\`) at the end of lines to omit line breaks in string's value:
    let softWrappedQuotation = """
    The White Rabbit put on his spectacles.  "Where shall I begin, \
    please your Majesty?" he asked.

    "Begin at the beginning," the King said gravely, "and go on \
    till you come to the end; then stop.
    """
//: To make a multiline string literal that begins or ends with a line feed, write a blank line as the first or last line:
    let lineBreaks = """

        This string starts with a line break.
            It also ends with a line break.

        """
//: The whitespace before the closing quotation marks (`"""`) tells Swift what whitespace to ignore before all of the other lines. \
//: Here the middle line has more indentation than the closing quotation marks, so it starts with that extra four-space indentation:
//:
//: ![Multiline String](multilineStringWhitespace_2x.png)
//:
//: ### Special Characters in String Literals
//: String literals can include the following special characters:
//: * The escaped special characters:
//:     * `\0` (null character)
//:     * `\\` (backslash)
//:     * `\t` (horizontal tab)
//:     * `\n` (line feed)
//:     * `\r` (carriage return)
//:     * `\"` (double quotation mark)
//:     * `\'` (single quotation mark)
//: * An arbitrary Unicode scalar value, written as `\u{n}`, where `n` is a 1–8 digit hexadecimal number. \
//: The code below shows four examples of these special characters:
    let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"

    let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024

    let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665

    let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
//: To include the text `"""` in a multiline string, escape at least one of the quotation marks:
    let threeDoubleQuotationMarks = """
    Escaping the first quotation mark \"""
    Escaping all three quotation marks \"\"\"
    """
//: ## Extended String Delimiters
//: Place a string literal within _extended delimiters_ (i.e. surround with number signs (`#`)) to include special characters in a string without invoking their effect:
    print("Line 1\nLine 2") // Regular string literal: line feed character is rendered

    print(#"Line 1\nLine 2"#) // String literal with extended delimiters: line feed character is included in the string
//: Break the line using:
    print(#"Line 1\#nLine 2"#)

    print(###"Line 1\###nLine 2"###)
//: Use extended delimiters to include the text `"""` in a multiline string, overriding the default behavior that ends the literal:
    let threeMoreDoubleQuotationMarks = #"""
    Here are three more double quotes: """
    """#
    print(threeMoreDoubleQuotationMarks)
//: ## Initializing an Empty String
//: Create an empty string using an empty string literal or initializer syntax:
    var emptyString = ""

    var anotherEmptyString = String()
//: Find out whether a `String` value is empty:
    if emptyString.isEmpty {
        print("Nothing to see here")
    }
//: ## String Mutability
//: Make a `String` _mutable_ by assigning it to a variable, or _immutable_ by assigning it to a constant:
    var variableString = "Horse"

    variableString += " and carriage"

    let constantString = "Highlander"
//: 🧨 _uncomment following lines to see the error_
//    constantString += " and another Highlander"
//    // this reports a compile-time error - a constant string cannot be modified
//: - - -
//: ✏️ This approach is different from string mutation in Objective-C and Cocoa, where you choose between two classes (`NSString` and `NSMutableString`) to indicate whether a string can be mutated.
//: - - -
//: ## Strings are Value Types
//: Swift’s `String` type is a _value type_. \
//: `String` value is _copied_ when it’s passed to a function or method, or when it’s assigned to a constant or variable.
//: - - -
//: ✏️ Behind the scenes, Swift’s compiler optimizes string usage so that actual copying takes place only when absolutely necessary.
//: - - -
//: ## Working with Characters
//: Access the individual `Character` values for a `String` by iterating over the string with a `for-in` loop:
    for character in "Dog!🐶" {
        print(character)
    }
//: Create a _stand-alone_ `Character` constant or variable from a single-character string literal by providing a `Character` type annotation:
    let exclamationMark: Character = "!"
//: `String` values can be constructed by passing an array of `Character` values as an argument to its initializer:
    let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]

    let catString = String(catCharacters)
//: ## Concatenating Strings and Characters
//: Add (or _concatenate_) `String` values together with the addition operator (`+`):
    let string1 = "hello"

    let string2 = " there"

    var welcome = string1 + string2
//: Append a `String` value to an existing `String` variable with the addition assignment operator (+=):
    var instruction = "look over"

    instruction += string2
//: Append a `Character` value to a `String variable` with the `String` type’s `append()` method:
    let exclamation: Character = "!"

    welcome.append(exclamation)
//: - - -
//: ✏️ You can’t append a `String` or `Character` to an existing `Character` variable, because a `Character` value must contain a single character only.
//: - - -
//: When using multiline string literals to build up the lines of a longer string, you want every line in the string to end with a line break, including the last line:
    let badStart = """
    one
    two
    """

    let end = """
    three
    """

    print(badStart + end)

    let goodStart = """
    one
    two

    """

    print(goodStart + end)
//: ## String Interpolation
//: Construct a new `String` value from a mix of constants, variables, literals, and expressions using _string interpolation_.
//: Each item that you insert into the string literal is wrapped in a pair of parentheses, prefixed by a backslash (`\`):
    let multiplier = 3

    let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
//: Use extended string delimiters to create strings containing characters that would otherwise be treated as a string interpolation:
    print(#"Write an interpolated string in Swift using \(multiplier)."#)
//: To use string interpolation inside a string that uses extended delimiters, match the number of number signs before the backslash to the number of number signs at the beginning and end of the string:
    print(#"6 times 7 is \#(6 * 7)."#)

    var o = 60.0 + 300
    print(o)

//: ## Unicode
//: _Unicode_ is an international standard for encoding, representing, and processing text in different writing systems. It enables you to represent almost any character from any language in a standardized form, and to read and write those characters to and from an external source such as a text file or web page. Swift’s `String` and `Character` types are fully _Unicode-compliant_.
//: ### Unicode Scalar Values
//: Swift’s native `String` type is built from _Unicode scalar values_. A Unicode scalar value is a unique 21-bit number for a character or modifier, such as `U+0061` for `LATIN SMALL LETTER A` (`"a"`), or `U+1F425` for `FRONT-FACING BABY CHICK` (`"🐥"`).
//: Some scalars are reserved for future assignment or for use in UTF-16 encoding.
//: Scalar values that have been assigned to a character typically also have a name (e.g. `LATIN SMALL LETTER A` or `FRONT-FACING BABY CHICK`).
//: ### Extended Grapheme Clusters
//: Every instance of Swift’s `Character` type represents a single _extended grapheme cluster_ - a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character.
//: In the first case, the cluster contains a single scalar; in the second case, it’s a cluster of two scalars:
    let eAcute: Character = "\u{E9}"

    let combinedEAcute: Character = "\u{65}\u{301}"
    // eAcute is é, combinedEAcute is é"
//: Hangul syllables from the Korean alphabet can be represented as either a precomposed or decomposed sequence. Both of these representations qualify as a single `Character` value in Swift:
    let precomposed: Character = "\u{D55C}" // 한

    let decomposed: Character = "\u{1112}\u{1161}\u{11AB}" // ᄒ, ᅡ, ᆫ
//: Extended grapheme clusters enable scalars for enclosing marks (such as `COMBINING ENCLOSING CIRCLE`, or `U+20DD`) to enclose other Unicode scalars as part of a single `Character` value:
    let enclosedEAcute: Character = "\u{E9}\u{20DD}"
//: Unicode scalars for regional indicator symbols can be combined in pairs to make a single `Character` value, such as this combination of `REGIONAL INDICATOR SYMBOL LETTER U` (`U+1F1FA`) and `REGIONAL INDICATOR SYMBOL LETTER S` (`U+1F1F8`):
    let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
//: ## Counting Characters
//: Retrieve a count of the `Character` values in a `String` using it's `count` property:
    let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"

    print("unusualMenagerie has \(unusualMenagerie.count) characters")
//: String concatenation and modification may not always affect a string’s character count. If you initialize a new string with the four-character word `cafe`, and then append a `COMBINING ACUTE ACCENT` (`U+0301`) to the end of the string, the resulting string will still have a character count of 4, with a fourth character of `é`, not `e`:
    var word = "cafe"

    print("the number of characters in \(word) is \(word.count)")

    word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

    print("the number of characters in \(word) is \(word.count)")
//: - - -
//: ✏️ Extended grapheme clusters can be composed of multiple Unicode scalars. This means that different characters—and different representations of the same character—can require different amounts of memory to store. Because of this, characters in Swift don’t each take up the same amount of memory within a string’s representation. As a result, the number of characters in a string can’t be calculated without iterating through the string to determine its extended grapheme cluster boundaries. If you are working with particularly long string values, be aware that the count property must iterate over the Unicode scalars in the entire string in order to determine the characters for that string.
//: - - -
//: The count of the characters returned by the count property isn’t always the same as the length property of an `NSString` that contains the same characters. The length of an `NSString` is based on the number of 16-bit code units within the string’s UTF-16 representation and not the number of Unicode extended grapheme clusters within the string.
//: ## Accessing and Modifying a String
//: Access and modify a string through its methods and properties, or by using subscript syntax.
//: ### String Indices
//: Each `String` value has an associated index type, `String.Index`, which corresponds to the position of each `Character` in the string.
//: * Use the `startIndex` property to access the position of the first `Character`.
//: * The `endIndex` property is the position _after_ the last character in a `String`. The `endIndex` property isn’t a valid argument to a string’s subscript.
//: * If a `String` is empty, `startIndex` and `endIndex` are equal.
//: Access the indices before and after a given index using the `index(before:)` and `index(after:)` methods of `String`.
//: * To access an index farther away from the given index, you can use the `index(_:offsetBy:)` method instead of calling one of these methods multiple times.
//: Use subscript syntax to access the `Character` at a particular `String` index.
    let greeting = "Guten Tag!"

    greeting[greeting.startIndex]

    greeting[greeting.index(before: greeting.endIndex)]

    greeting[greeting.index(after: greeting.startIndex)]

    let index = greeting.index(greeting.startIndex, offsetBy: 7)

    greeting[index]
//: Attempting to access an index outside of a string’s range or a `Character` at an index outside of a string’s range will trigger a runtime error.
//:
//: 🧨 _uncomment following lines to see the error_
//:
//    greeting[greeting.endIndex]
//
//    greeting.index(after: greeting.endIndex)
//: Use the `indices` property to access all of the indices of individual characters in a string.
    for index in greeting.indices {
        print("\(greeting[index]) ", terminator: "")
    }
//: - - -
//: ✏️ Use the `startIndex` and `endIndex` properties and the `index(before:)`, `index(after:)`, and `index(_:offsetBy:)` methods on any type that conforms to the `Collection` protocol. This includes `String`, as shown here, as well as collection types such as `Array`, `Dictionary`, and `Set`.
//: - - -
//: ### Insering and Removing
//: Insert a single character into a string at a specified index using the `insert(_:at:)` method, and insert the contents of another string at a specified index using the `insert(contentsOf:at:)` method.
    var greet = "hello"

    greet.insert("!", at: greet.endIndex)

    greet.insert(contentsOf: " there", at: greet.index(before:  greet.endIndex))
//: Remove a single character from a string at a specified index with the `remove(at:)` method, and remove a substring at a specified range with the `removeSubrange(_:)` method:
    welcome.remove(at: welcome.index(before: welcome.endIndex))

    let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex

    welcome.removeSubrange(range)
//: - - -
//: ✏️ You can use the `insert(_:at:)`, `insert(contentsOf:at:)`, `remove(at:)`, and `removeSubrange(_:)` methods on any type that conforms to the `RangeReplaceableCollection` protocol. This includes `String`, as shown here, as well as collection types such as `Array`, `Dictionary`, and `Set`.
//: - - -
//: ## Substrings
//: * When you get a substring from a string — for example, using a subscript or a method like `prefix(_:)` — the result is an instance of `Substring`.
//: * Substrings in Swift have most of the same methods as strings, which means you can work with substrings the same way you work with strings.
//: * However, unlike strings, you use substrings for only a short amount of time while performing actions on a string. \
//: When you’re ready to store the result for a longer time, you convert the substring to an instance of `String`:
    let proposition = "Cogito, ergo sum!"

    let indexOfFirstComma = proposition.firstIndex(of: ",") ?? proposition.endIndex

    let beginning = proposition[..<indexOfFirstComma]
    type(of: beginning)

    // Convert the result to a String for long-term storage.
    let newString = String(beginning)
//: As a performance optimization, a substring can reuse part of the memory that’s used to store the original string, or part of the memory that’s used to store another substring. (Strings have a similar optimization, but if two strings share memory, they are equal.) This performance optimization means you don’t have to pay the performance cost of copying memory until you modify either the string or substring.
//: \
//: ![String-Substring](stringSubstring_2x.png)
//: - - -
//: ✏️ Substrings aren’t suitable for long-term storage — because they reuse the storage of the original string, the entire original string must be kept in memory as long as any of its substrings are being used.
//: - - -
//: ## Comparing Strings
//: Swift provides three ways to compare textual values:
//: * String and character equality
//: * Prefix equality
//: * Suffix equality
//: ### String and Character Equality
//: String and character equality is checked with the “equal to” operator (`==`) and the “not equal to” operator (`!=`):
    let quote = "We're a lot alike, you and I."

    let sameQuote = "We're a lot alike, you and I."

    if quote == sameQuote {
        print("These two strings are considered equal")
    }
//: Two `String` values (or two `Character` values) are considered equal if their extended grapheme clusters are _canonically equivalent_. \
//: Extended grapheme clusters are canonically equivalent if they have the same linguistic meaning and appearance, even if they’re composed from different Unicode scalars behind the scenes. \
//: For example, `LATIN SMALL LETTER E WITH ACUTE` (`U+00E9`) is canonically equivalent to `LATIN SMALL LETTER E` (`U+0065`) followed by `COMBINING ACUTE ACCENT` (`U+0301`).
    // "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
    let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"

    // "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
    let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"

    if eAcuteQuestion == combinedEAcuteQuestion {
        print("These two strings are considered equal")
    }
//: Conversely, `LATIN CAPITAL LETTER A` (`U+0041`, or `"A"`), as used in English, is not equivalent to `CYRILLIC CAPITAL LETTER A` (`U+0410`, or `"А"`), as used in Russian. The characters are visually similar, but don’t have the same linguistic meaning:
    let latinCapitalLetterA: Character = "\u{41}"

    let cyrillicCapitalLetterA: Character = "\u{0410}"

    if latinCapitalLetterA != cyrillicCapitalLetterA {
        print("These two characters are not equivalent.")
    }
//: ### Prefix and Suffix Equality
//: To check whether a string has a particular string prefix or suffix, call the string’s `hasPrefix(_:)` and `hasSuffix(_:)` methods, both of which take a single argument of type `String` and return a `Boolean` value. \
//: Consider an array of strings:
    let romeoAndJuliet = [
        "Act 1 Scene 1: Verona, A public place",
        "Act 1 Scene 2: Capulet's mansion",
        "Act 1 Scene 3: A room in Capulet's mansion",
        "Act 1 Scene 4: A street outside Capulet's mansion",
        "Act 1 Scene 5: The Great Hall in Capulet's mansion",
        "Act 2 Scene 1: Outside Capulet's mansion",
        "Act 2 Scene 2: Capulet's orchard",
        "Act 2 Scene 3: Outside Friar Lawrence's cell",
        "Act 2 Scene 4: A street in Verona",
        "Act 2 Scene 5: Capulet's mansion",
        "Act 2 Scene 6: Friar Lawrence's cell"
    ]
//: Use the `hasPrefix(_:)` method with the `romeoAndJuliet` array to count the number of scenes in Act 1 of the play:
    var act1SceneCount = 0

    for scene in romeoAndJuliet {
        if scene.hasPrefix("Act 1 ") {
            act1SceneCount += 1
        }
    }

    print("There are \(act1SceneCount) scenes in Act 1")
//: Use the `hasSuffix(_:)` method to count the number of scenes that take place in or around Capulet’s mansion and Friar Lawrence’s cell:
    var mansionCount = 0

    var cellCount = 0

    for scene in romeoAndJuliet {
        if scene.hasSuffix("Capulet's mansion") {
            mansionCount += 1
        } else if scene.hasSuffix("Friar Lawrence's cell") {
            cellCount += 1
        }
    }

    print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
//: - - -
//: ✏️ The `hasPrefix(_:)` and `hasSuffix(_:)` methods perform a character-by-character canonical equivalence comparison between the extended grapheme clusters in each string.
//: - - -
//: ## Unicode Representations of Strings
//: When a Unicode string is written to a text file or some other storage, the Unicode scalars in that string are encoded in one of several Unicode-defined _encoding forms_. Each form encodes the string in small chunks known as _code units_.
//: These include:
//: * The UTF-8 encoding form (which encodes a string as 8-bit code units)
//: * The UTF-16 encoding form (which encodes a string as 16-bit code units)
//: * The UTF-32 encoding form (which encodes a string as 32-bit code units).
//: Access a `String` value in one of three other Unicode-compliant representations:
//: * A collection of UTF-8 code units (accessed with the string’s `utf8` property)
//: * A collection of UTF-16 code units (accessed with the string’s `utf16` property)
//: * A collection of 21-bit Unicode scalar values, equivalent to the string’s UTF-32 encoding form (accessed with the string’s `unicodeScalars` property)
    let dogString = "Dog‼🐶"
//: ### UTF-8 Representation
//: Access a UTF-8 representation of a `String` by iterating over its `utf8` property. This property is of type `String.UTF8View`, which is a collection of unsigned 8-bit (`UInt8`) values, one for each byte in the string’s UTF-8 representation:
    for codeUnit in dogString.utf8 {
        print("\(codeUnit) ", terminator: "")
    }
    print("")
//: The first three decimal codeUnit values (`68`, `111`, `103`) represent the characters `D`, `o`, and `g`, whose UTF-8 representation is the same as their ASCII representation. The next three decimal codeUnit values (`226`, `128`, `188`) are a three-byte UTF-8 representation of the `DOUBLE EXCLAMATION MARK` character. The last four codeUnit values (`240`, `159`, `144`, `182`) are a four-byte UTF-8 representation of the `DOG FACE` character.
//: ### UTF-16 Representation
//: Access a UTF-16 representation of a `String` by iterating over its `utf16` property. This property is of type `String.UTF16View`, which is a collection of unsigned 16-bit (`UInt16`) values, one for each 16-bit code unit in the string’s UTF-16 representation:
    for codeUnit in dogString.utf16 {
        print("\(codeUnit) ", terminator: "")
    }

    print("")
//: * The first three codeUnit values (`68`, `111`, `103`) represent the characters `D`, `o`, and `g`, whose UTF-16 code units have the same values as in the string’s UTF-8 representation (because these Unicode scalars represent ASCII characters).
//: * The fourth codeUnit value (`8252`) is a decimal equivalent of the hexadecimal value `203C`, which represents the Unicode scalar `U+203C` for the `DOUBLE EXCLAMATION MARK` character. This character can be represented as a single code unit in UTF-16.
//: The fifth and sixth codeUnit values (`55357` and `56374`) are a UTF-16 surrogate pair representation of the `DOG FACE` character. These values are a high-surrogate value of `U+D83D` (decimal value `55357`) and a low-surrogate value of `U+DC36` (decimal value `56374`).
//: ### Unicode Scalar Representation
//: Access a Unicode scalar representation of a `String` value by iterating over its `unicodeScalars` property. This property is of type `UnicodeScalarView`, which is a collection of values of type `UnicodeScalar`. \
//: Each `UnicodeScalar` has a `value` property that returns the scalar’s 21-bit value, represented within a `UInt32` value:
    for scalar in dogString.unicodeScalars {
        print("\(scalar.value) ", terminator: "")
    }

    print("")
//: * The value properties for the first three UnicodeScalar values (`68`, `111`, `103`) once again represent the characters `D`, `o`, and `g`.
//: * The fourth `codeUnit` value (`8252`) is again a decimal equivalent of the hexadecimal value `203C`, which represents the Unicode scalar `U+203C` for the `DOUBLE EXCLAMATION MARK` character.
//: * The value property of the fifth and final `UnicodeScalar`, `128054`, is a decimal equivalent of the hexadecimal value `1F436`, which represents the Unicode scalar `U+1F436` for the `DOG FACE` character.
//: As an alternative to querying their value properties, each `UnicodeScalar` value can also be used to construct a new `String` value, such as with string interpolation:
    for scalar in dogString.unicodeScalars {
        print("\(scalar) ")
    }
//:
//: [Next →](@next)
