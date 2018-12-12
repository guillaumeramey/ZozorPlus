import Foundation
import UIKit

class Calculation {
    // MARK: - Properties
    enum Operator: String {
        case plus = "+"
        case minus = "-"
    }
    var displayString = ""
    var total = 0
    var numbers = [String()]
    var operators: [Operator] = [.plus]
    var alertMessage = ""
    private var isExpressionCorrect: Bool {
        if let number = numbers.last {
            if number.isEmpty {
                return false
            }
        }
        return true
    }

    // MARK: - Methods
    func addNumber(_ newNumber: Int) {
        if var lastNumber = numbers.last {
            lastNumber += String(newNumber)
            numbers[numbers.count-1] = lastNumber
        }
        displayString += String(newNumber)
    }

    func addOperator(_ newOperator: Operator) -> Bool {
        if isExpressionCorrect {
            operators.append(newOperator)
            numbers.append("")
            displayString += newOperator.rawValue
            return true
        } else {
            alertMessage = "Expression incorrecte !"
            return false
        }
    }

    func evaluate() -> Bool {
        if isExpressionCorrect {
            var currentStringTotal = 0
            for (index, number) in numbers.enumerated() {
                if let currentNumber = Int(number) {
                    switch operators[index] {
                    case .plus:
                        currentStringTotal += currentNumber
                    case .minus:
                        currentStringTotal -= currentNumber
                    }
                }
            }
            total = currentStringTotal
            clearDisplayString()
            return true
        } else {
            if numbers.count == 1 {
                alertMessage = "Démarrez un nouveau calcul !"
            } else {
                alertMessage = "Entrez une expression correcte !"
            }
            return false
        }
    }

    func delete() -> Bool {
        if displayString.count > 0 {
            displayString.removeLast(1)
            // number or operator ?
            if var lastNumber = numbers.last {
                if lastNumber.isEmpty {
                    operators.removeLast(1)
                    numbers.removeLast(1)
                } else {
                    lastNumber.removeLast(1)
                    numbers[numbers.count-1] = lastNumber
                }
            }
            return true
        } else {
            alertMessage = "Rien à effacer !"
            return false
        }
    }

    func clearDisplayString() {
        numbers = [String()]
        operators = [.plus]
        displayString = ""
    }
}
