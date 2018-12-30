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
    private var calculation: Calculation!

    // MARK: - Outlets
    @IBOutlet weak var calculatorDisplay: UITextView!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        calculation = Calculation()
    }

    // updates the display if the input is ok
    private func updateDisplay(if success: Bool = true) {
        if success {
            calculatorDisplay.text = calculation.displayString
        } else {
            alert()
        }
    }

    // Presents an alert with a customized pessage
    private func alert() {
        let alertVC = UIAlertController(title: "Erreur", message: calculation.alertMessage, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    // MARK: - Actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        calculation.addNumber(sender.tag)
        updateDisplay()
    }

    @IBAction func plus() {
        let success = calculation.addOperator(.plus)
        updateDisplay(if: success)
    }

    @IBAction func minus() {
        let success = calculation.addOperator(.minus)
        updateDisplay(if: success)
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
        updateDisplay(if: success)
    }

    @IBAction func clear() {
        calculation.clear()
        updateDisplay()
    }
}
