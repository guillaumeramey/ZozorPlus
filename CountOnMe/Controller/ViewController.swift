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
    var calculation: Calculation!

    // MARK: - Outlets
    @IBOutlet weak var calculatorDisplay: UITextView!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        calculation = Calculation()
    }

    func alert() {
        let alertVC = UIAlertController(title: "Erreur", message: calculation.alertMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func updateDisplay() {
        calculatorDisplay.text = calculation.displayString
    }

    // MARK: - Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculation.addNumber(sender.tag)
        updateDisplay()
    }

    @IBAction func plus() {
        let success = calculation.addOperator(.plus)
        if success {
            updateDisplay()
        } else {
            alert()
        }
    }

    @IBAction func minus() {
        let success = calculation.addOperator(.minus)
        if success {
            updateDisplay()
        } else {
            alert()
        }
    }

    @IBAction func equal() {
        let success = calculation.evaluate()
        if success {
            calculatorDisplay.text += "=" + calculation.total.description
        } else {
            alert()
        }
    }

    @IBAction func delete() {
        let success = calculation.delete()
        if success {
            updateDisplay()
        } else {
            alert()
        }
    }

    @IBAction func clear() {
        calculation.clearDisplayString()
        updateDisplay()
    }
}
