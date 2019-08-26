//: [↑ Contents](Contents) \
//: [← Previous](@previous)
//:
//: # Subscripts
//: Classes, structures, and enumerations can define subscripts, which are _shortcuts for accessing the member elements_ of a collection, list, or sequence. \
//: Use subscripts to _set and retrieve values by index_ without needing separate methods for setting and retrieval. \
//: You can _define multiple subscripts_ for a single type, and the appropriate subscript overload to use is selected based on the type of index value you pass to the subscript. \
//: Subscripts are not limited to a single dimension, and you can define _subscripts with multiple input_ parameters to suit your custom type’s needs.
//: ## Subscript Syntax
//: Subscripts enable you to query instances of a type by writing one or more values in square brackets after the instance name.
    struct TimesTable {
        let multiplier: Int
        subscript(index: Int) -> Int {
            return multiplier * index
        }
    }

    let threeTimesTable = TimesTable(multiplier: 3)

    print("six times three is \(threeTimesTable[6])")
//: ## Subscript Usage
//: Subscripts are typically used as a shortcut for accessing the member elements in a collection, list, or sequence. \
//: You are free to implement subscripts in the most appropriate way for your particular class or structure’s functionality.
/*:
 - Note:
 Swift’s `Dictionary` type implements its key-value subscripting as a subscript that takes and returns an _optional_ type. \
 The `Dictionary` type uses an optional subscript type to model the fact that not every key will have a value, and to give a way to delete a value for a key by assigning a nil value for that key.
 */
//: ## Subscript Options
//: Subscripts can take any number of input parameters, and these input parameters can be of any type. \
//: Subscripts can also return any type. \
//: Subscripts can use variadic parameters, but they can’t use in-out parameters or provide default parameter values. \
//: A class or structure can provide as many subscript implementations as it needs, this is known as _subscript overloading_. \
//: You can define a subscript with multiple parameters:
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Double]
        
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0.0, count: rows * columns)
        }
        
        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        
        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }

    var matrix = Matrix(rows: 2, columns: 2)

    matrix[0, 1] = 1.5

    matrix[1, 0] = 3.2
//:
//: [Next →](@next)
