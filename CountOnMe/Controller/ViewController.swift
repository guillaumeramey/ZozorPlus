//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var operation: Operation!

    // MARK: - Outlets
    @IBOutlet weak var calculatorDisplay: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (index, numberButton) in numberButtons.enumerated() where sender == numberButton {
            operation.addNewNumber(index)
            updateDisplay()
        }
    }
    @IBAction func plus() {
        let success = operation.addOperator(.plus)
        if success {
            updateDisplay()
        } else {
            alert()
        }
    }
    @IBAction func minus() {
        let success = operation.addOperator(.minus)
        if success {
            updateDisplay()
        } else {
            alert()
        }
    }
    @IBAction func equal() {
        let success = operation.calculateTotal()
        if success {
            calculatorDisplay.text += "=" + operation.total.description
        } else {
            alert()
        }
    }
    @IBAction func delete() {
        let success = operation.delete()
        if success {
            updateDisplay()
        } else {
            alert()
        }
    }
    @IBAction func clear() {
        operation.clearDisplayString()
        updateDisplay()
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        operation = Operation()
    }

    func alert() {
        let alertVC = UIAlertController(title: "Zéro!", message: operation.alertMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func updateDisplay() {
        calculatorDisplay.text = operation.displayString
    }
}
