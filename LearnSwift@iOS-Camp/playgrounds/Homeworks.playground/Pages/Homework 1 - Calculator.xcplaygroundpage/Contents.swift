    import PlaygroundSupport
import UIKit

enum ArithmeticOperation {
    case addition
    case subtraction
    case multiplication
    case division
    
    init?(key: CalculatorKey) {
        switch key {
        case .add: self = .addition
        case .subtract: self = .subtraction
        case .multiply: self = .multiplication
        case .divide: self = .division
        default:
            return nil
        }
    }
}

public class Controller: NSObject, CalculatorViewDelegate, CalculatorViewDataSource {
    var displayText = "0"
    var pressedDot = false
    var equalPressed = false
    var lastUsedNum  = 0.0
    var trackValue = 0.0
    var operation: ArithmeticOperation?
    public func prefixRemover(str: inout String, num: Int) -> Void?{
        if num < str.count{
            str = String(str.suffix(str.count - num))
        }
        return nil
    }
    public func clear() {
        displayText = "0"
        trackValue = 0.0
        operation = nil
        pressedDot = false
        equalPressed = false
    }
    
    public func calculator(firstNum: Double, secondNum: Double) -> Double {
        guard let operation = operation else {
            preconditionFailure() // do some error handling here
        }
        
        switch operation {
        case .addition:
            return firstNum + secondNum
        case .subtraction:
            return firstNum - secondNum
        case .multiplication:
            return firstNum * secondNum
        case .division:
            return firstNum / secondNum
        }
    }
    
    public func isNumber(num: String) -> Bool {
        return Double(num) != nil
    }
    
    public func calculatorView(_ calculatorView: CalculatorView, didPress key: CalculatorKey) {
        switch key {
        case .clear:
          clear()
            
        case .toggleSign:
            if isNumber(num: displayText){
                if displayText.prefix(1) == "-"{
                    if prefixRemover(str: &displayText, num: 1) != nil {}
                }
                else {
                    displayText = "-" + displayText
                }
            }
            
        case .number:
            if displayText == "0"{
                displayText = key.rawValue
            } else if displayText == "-0" {
                displayText = "-" + key.rawValue
            } else if equalPressed {
                clear()
                displayText = key.rawValue
            } else if isNumber(num: displayText) {
                displayText += key.rawValue
            } else {displayText = key.rawValue}
            equalPressed = false
            
        case .dot:
            if displayText == "" || equalPressed{
                clear()
                pressedDot = true
                displayText = "0" + key.rawValue
            } else if (!pressedDot) && isNumber(num: displayText){
                pressedDot = true
                displayText += key.rawValue
            } else if !pressedDot {
                displayText = "0" + key.rawValue
                pressedDot = true
            }

        case .percent:
            if isNumber(num: displayText) {
                if !equalPressed && operation != nil {
                    trackValue = calculator(firstNum: trackValue, secondNum: Double(displayText)!) / 100
                }
                else { trackValue = Double(displayText)! / 100}
                displayText = String(trackValue)
            }
            operation = nil
            equalPressed = true
            pressedDot = true
            
        case .equal:
            if isNumber(num: displayText), operation != nil  {
                if !equalPressed {
                    lastUsedNum = Double(displayText)!
                    equalPressed = true
                }
                trackValue = calculator(firstNum: trackValue, secondNum: lastUsedNum)
                displayText = String(trackValue)
            }
            
        case .add, .subtract, .multiply, .divide:
            if isNumber(num: displayText){
                if operation != nil, !equalPressed{
                    trackValue = calculator(firstNum: trackValue, secondNum: Double(displayText)!)
                }
                else {
                    trackValue = Double(displayText)!
                    pressedDot = false
                }
            }
            operation = ArithmeticOperation(key: key)
            displayText = key.rawValue
            equalPressed = false
            
        default:
            print("Undefined")
         }
    }
    
    public func displayText(_ calculatorView: CalculatorView) -> String {
        return displayText
    }
}
// Internal Setup
let controller = Controller(), page = PlaygroundPage.current
setupCalculatorView(for: page, with: controller)

