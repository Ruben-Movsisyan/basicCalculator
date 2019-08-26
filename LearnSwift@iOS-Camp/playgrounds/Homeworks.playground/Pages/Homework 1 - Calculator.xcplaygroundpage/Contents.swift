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
    let zero = CalculatorKey.number(0).rawValue;
    lazy var displayText = self.zero
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
        displayText = zero
        trackValue = 0.0
        operation = nil
        pressedDot = false
        equalPressed = false
    }
    
    public func calculator(firstNum: Double, secondNum: Double) -> Double {
        guard let operation = operation else {
            preconditionFailure("Error: Attempt for undefined operation")
            
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
                if displayText.prefix(1) == CalculatorKey.subtract.rawValue {
                    if prefixRemover(str: &displayText, num: 1) != nil {}
                }
                else {
                    displayText = CalculatorKey.subtract.rawValue + displayText
                }
            }
            
        case .number:
            if displayText == zero {
                displayText = key.rawValue
            } else if displayText == CalculatorKey.subtract.rawValue + zero {
                displayText = CalculatorKey.subtract.rawValue + key.rawValue
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
                displayText = zero + key.rawValue
            } else if (!pressedDot) && isNumber(num : displayText){
                pressedDot = true
                displayText += key.rawValue
            } else if !pressedDot {
                displayText = zero + key.rawValue
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
            if displayText.suffix(2) == CalculatorKey.dot.rawValue + zero {
                displayText = String(displayText.prefix(displayText.count - 2))
                
                //displayText.removeSubrange(displayText.index(displayText.endIndex, offsetBy: -2)..<displayText.endIndex)
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
                if displayText.suffix(2) == CalculatorKey.dot.rawValue + zero {
                    displayText = String(displayText.prefix(displayText.count - 2))
                    
                    //displayText.removeSubrange(displayText.index(displayText.endIndex, offsetBy: -2)..<displayText.endIndex)
                }
                
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

