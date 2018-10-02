//
//  ViewController.swift
//  Make some code
//
//  Created by Njabulo MAJOZI on 2018/10/01.
//  Copyright © 2018 mrenmajozi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayScreenLabel: UILabel!
    var isTypingNumbers = false
    var isTypingOperator = false
    var firstTimeOperator = true
    var previousValue = 0.0
    var operatorSymbol = ""
    
    @IBAction func numberButton(_ sender: UIButton) {
        print("Clicked: \(sender.currentTitle!)")
        
        if displayScreenLabel.text!.range(of:"ERROR") != nil {
            clearScreen()
        }
        
        if (displayValue == 0.0) {
            isTypingNumbers = true
            displayScreenLabel.text = sender.currentTitle!
        } else {
            if isTypingNumbers {
                displayScreenLabel.text = displayScreenLabel.text! + sender.currentTitle!
            } else {
                isTypingNumbers = true
                displayScreenLabel.text = sender.currentTitle!
            }
        }
    }
    
    var displayValue: Double {
        get {
            return Double(displayScreenLabel.text!)!
        }
        
        set {
            //displayScreenLabel.text = String(newValue)
            
            displayScreenLabel.text = String(Double(round(1000000000 * newValue)/1000000000))
        }
    }
    
    func clearScreen() {
        isTypingNumbers = false
        displayScreenLabel.text = "0.0"
        operatorSymbol = ""
        previousValue = 0.0
        firstTimeOperator = true
    }
    
    @IBAction func clearButton(_ sender: UIButton) {
        print("Clicked: AC")
        clearScreen()
    }
    
    @IBAction func negativeButton(_ sender: UIButton) {
        print("Clicked: NEG")
        if displayScreenLabel.text!.range(of:"ERROR") != nil {
            clearScreen()
        }
        
        operatorSymbol = ""
        previousValue = 0.0
        
        isTypingNumbers = false
        if (displayValue != 0.0){
            displayValue = displayValue * -1
        }
    }
    
    func performEqual(){
        print(previousValue)
        print(operatorSymbol)
        print(displayValue)
        
        isTypingNumbers = false
        if (operatorSymbol == "+"){
            displayScreenLabel.text = String(previousValue + displayValue)
        } else if (operatorSymbol == "-"){
            displayScreenLabel.text = String(previousValue - displayValue)
        } else if (operatorSymbol == "*"){
            displayScreenLabel.text = String(previousValue * displayValue)
        } else if (operatorSymbol == "/"){
            if (displayValue == 0.0){
                displayScreenLabel.text = "ERROR: Zero Division"
            } else {
                displayScreenLabel.text = String(previousValue / displayValue)
            }
        }
        operatorSymbol = ""
        previousValue = 0.0
    }
    
    func getOperatorSymbol(fromOperator toOperator: String) {
        if isTypingOperator {
            if (firstTimeOperator){
                previousValue = displayValue
                displayScreenLabel.text = "0.0"
                operatorSymbol = toOperator
                firstTimeOperator = false
            } else {
                operatorSymbol = toOperator
                performEqual()
                operatorSymbol = toOperator
                previousValue = displayValue
            }
        } else {
            previousValue = displayValue
            displayScreenLabel.text = "0.0"
            operatorSymbol = toOperator
        }
        
    }
    
    @IBAction func operationButton(_ sender: UIButton) {
        if displayScreenLabel.text!.range(of:"ERROR") != nil {
            clearScreen()
        }
        
        switch sender.currentTitle {
            case "+":
                print("Clicked: +")
                isTypingOperator = true
                getOperatorSymbol(fromOperator: "+")
            case "-":
                print("Clicked: -")
                isTypingOperator = true
                getOperatorSymbol(fromOperator: "-")
            case "*":
                print("Clicked: *")
                isTypingOperator = true
                getOperatorSymbol(fromOperator: "*")
            case "/":
                print("Clicked: /")
                isTypingOperator = true
                getOperatorSymbol(fromOperator: "/")
            default:
                print("Clicked: =")
                isTypingOperator = false
                firstTimeOperator = true
                performEqual()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

