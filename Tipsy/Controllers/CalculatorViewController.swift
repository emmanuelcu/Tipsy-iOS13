//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var persons = 2
    var tipWithoutSign = 0
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let butttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsNumber = Double(butttonTitleMinusPercentSign)!
        tip = buttonTitleAsNumber / 100
        tipWithoutSign = Int(butttonTitleMinusPercentSign)!
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        persons = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        calculateTip()
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    func calculateTip() -> String{
        let amount = billTextField.text!
        
        if amount == ""{
            return ("Error")
        }else{
            let amountToNumber = Double(amount)!
            let amountSplited = amountToNumber * (1 + tip) / Double(persons)
            let resultToDecimalPlaces = String(format: "%.2f", amountSplited)
            return resultToDecimalPlaces
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.tipResult = calculateTip()
            destinationVC.totalTip = tipWithoutSign
            destinationVC.totalPersons = persons
        }
    }
    
}

