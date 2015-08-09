//
//  ViewController.swift
//  Calcul8r
//
//  Created by Ryan Holdaway on 8/5/15.
//  Copyright (c) 2015 Ryan Holdaway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var display: UILabel!

  var userIsInTheMiddleOfTypingANumber = false

  @IBAction func appendDigit(sender: UIButton) {
    let digit = sender.currentTitle!
    if userIsInTheMiddleOfTypingANumber {
      display.text = display.text! + digit
    } else {
      display.text = digit
      userIsInTheMiddleOfTypingANumber = true
    }
  }

  @IBAction func enterNumbers() {
    userIsInTheMiddleOfTypingANumber = false
    numberStack.append(displayValue)
  }

  @IBAction func operate(sender: UIButton) {
    let operation = sender.currentTitle!
    if userIsInTheMiddleOfTypingANumber {
      enterNumbers()
    }
    switch operation {
      case "×": performOperation { $0 * $1 }
      case "÷": performOperation { $1 / $0 }
      case "+": performOperation { $0 + $1 }
      case "−": performOperation { $1 - $0 }
      case "√": performBigOperation { sqrt($0) }
      default: break
    }
  }

  func performOperation(operation: (Double, Double) -> Double) {
    if numberStack.count >= 2 {
      displayValue = operation(numberStack.removeLast(), numberStack.removeLast())
      enterNumbers()
    }
  }

  func performBigOperation(operation: Double -> Double) {
    if numberStack.count >= 1 {
      displayValue = operation(numberStack.removeLast())
      enterNumbers()
    }
  }

  var numberStack = Array<Double>()

  var displayValue: Double {
    get {
      return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
    }
    set {
      display.text = "\(newValue)"
      userIsInTheMiddleOfTypingANumber = false
    }
  }

}