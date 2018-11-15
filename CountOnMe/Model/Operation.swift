import Foundation
import UIKit

class Operation {
    // MARK: - Properties
    enum Operators: String {
        case plus = "+"
        case minus = "-"
    }
    var displayString = ""
    var total = 0
    var stringNumbers = [String()]
    var operators: [Operators] = [.plus]
    var alertMessage = ""
    private var isExpressionCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                return false
            }
        }
        return true
    }

    // MARK: - Methods
    func addNewNumber(_ newNumber: Int) {
        if var stringNumber = stringNumbers.last {
            stringNumber += String(newNumber)
            stringNumbers[stringNumbers.count-1] = stringNumber
        }
        displayString += String(newNumber)
    }

    func addOperator(_ newOperator: Operators) -> Bool {
        if isExpressionCorrect {
            operators.append(newOperator)
            stringNumbers.append("")
            displayString += newOperator.rawValue
            return true
        } else {
            alertMessage = "Expression incorrecte !"
            return false
        }
    }

    func calculateTotal() -> Bool {
        if isExpressionCorrect {
            var currentStringTotal = 0
            for (index, stringNumber) in stringNumbers.enumerated() {
                if let number = Int(stringNumber) {
                    switch operators[index] {
                    case .plus:
                        currentStringTotal += number
                    case .minus:
                        currentStringTotal -= number
                    }
                }
            }
            total = currentStringTotal
            clearDisplayString()
            return true
        } else {
            if stringNumbers.count == 1 {
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
            if var stringNumber = stringNumbers.last {
                if stringNumber.isEmpty {
                    operators.removeLast(1)
                    stringNumbers.removeLast(1)
                } else {
                    stringNumber.removeLast(1)
                    stringNumbers[stringNumbers.count-1] = stringNumber
                }
            }
            return true
        } else {
            alertMessage = "Rien à effacer !"
            return false
        }
    }

    func clearDisplayString() {
        stringNumbers = [String()]
        operators = [.plus]
        displayString = ""
    }
}
