/*:
 # First Recurring Character
 ## Objective
 Find the first recurring character in an input string. Return “nil” if there is no such character.
 
 ## Sample Data
 
 **Input**         **Output**
 - - -
 “ABCA”          “A”        \
 “ABBA”          “B”        \
 “ABC”            nil
 - - -
 */
//: ## Solutions
//: ### 1. Tracking smallest index of recurrence
//:    **Time complexity**: O(n * m)\
//:    **Auxiliary space**: O(1)
func firstRecurring1(in str: String) -> Character? {
    var resultIdx = str.endIndex
    for (idx, char) in str.enumerated() {
        if let recurrenceIdx = str.dropFirst(idx + 1).firstIndex(of: char),
            str.distance(from: recurrenceIdx, to: resultIdx) > 0 {
            resultIdx = recurrenceIdx
        }
    }
    return resultIdx == str.endIndex ? nil : str[resultIdx]
}
//: #### Solution Test:
let inputs = ["ABCA", "ABBA", "ABC", "ABCDDCBA"]

let recurrences1 = inputs.map { firstRecurring1(in: $0) }
print(recurrences1)
//: - - -
//: ### 2. Using `Set`
//:    **Time complexity**: O(n)\
//:    **Auxiliary space**: O(n)
func firstRecurring2(in str: String) -> Character? {
    var seen = Set<Character>()
    for char in str {
        if !seen.insert(char).inserted {
            return char
        }
    }
    return nil
}
//: #### Solution Test
let recurrences2 = inputs.map { firstRecurring2(in: $0) }
print(recurrences2)
