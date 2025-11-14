//
//  ViewController.swift
//  Lesson 2.4 Знакомство с фреймворком UIKit. Работа с документацией
//
//  Created by Anzhelika on 06.10.25.
//

import UIKit

final class ColorPaleteViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var colorPalete: UIView!
    
    @IBOutlet var redColor: UISlider!
    @IBOutlet var greenColor: UISlider!
    @IBOutlet var blueColor: UISlider!
    
    @IBOutlet var redColorValue: UILabel!
    @IBOutlet var greenColorValue: UILabel!
    @IBOutlet var blueColorValue: UILabel!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var doneButton: UIButton!
    
    // MARK: - Private properties
    var delegate: ColorPaleteViewControllerDelegate!
    var viewColor: UIColor!
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorPalete.layer.cornerRadius = 10
        
        colorPalete.backgroundColor = viewColor
        
        setValue(for: redColor, greenColor, blueColor)
        setValue(for: redColorValue, greenColorValue, blueColorValue)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction private func changeColor(_ sender: UISlider) {
        switch sender {
        case redColor:
            setValue(for: redColorValue)
            setValue(for: redTextField)
        case greenColor:
            setValue(for: greenColorValue)
            setValue(for: greenTextField)
        default:
            setValue(for: blueColorValue)
            setValue(for: blueTextField)
        }
        
        setColor()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        delegate.setColor(colorPalete.backgroundColor ?? .white)
        dismiss(animated: true)
    }

   
}

// MARK: - Private methods
extension ColorPaleteViewController {
    private func setColor() {
        colorPalete.backgroundColor = UIColor(
            red: CGFloat(redColor.value),
            green: CGFloat(greenColor.value),
            blue: CGFloat(blueColor.value),
            alpha: 1
        )
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setValue(for labels: UILabel...) {
        for label in labels {
            switch label {
            case redColorValue:
                label.text = string(from: redColor)
            case greenColorValue:
                label.text = string(from: greenColor)
            default:
                label.text = string(from: blueColor)
            }
        }
    }
    
    private func setValue(for sliders: UISlider...) {
        let ciColor = CIColor(color: viewColor)
        for slider in sliders {
            switch slider {
                case redColor:
                redColor.value = Float(ciColor.red)
            case greenColor:
                greenColor.value = Float(ciColor.green)
            default:
                blueColor.value = Float(ciColor.blue)
            }
        }
    }
    
    private func setValue(for textField: UITextField...) {
        for textField in textField {
            switch textField {
            case redTextField:
                redTextField.text = string(from: redColor)
            case greenTextField:
                greenTextField.text = string(from: greenColor)
            default:
                blueTextField.text = string(from: blueColor)
            }
        }
    }
    
    private func showAlert(
        withTitle title: String,
        andMessage message: String,
        textField: UITextField? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "0.50"
            textField?.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
        
    }
}

extension ColorPaleteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyBoardToolbar = UIToolbar()
        keyBoardToolbar.sizeToFit()
        textField.inputAccessoryView = keyBoardToolbar
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyBoardToolbar.items = [flexibleSpace, doneButton]
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard var text = textField.text else {
            showAlert(withTitle: "Неверные данные!", andMessage: "Введите корректные данные")
            return
        }
        
        text = text.replacingOccurrences(of: ",", with: ".")

        
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                withTitle: "Неверные данные!",
                andMessage: "Введите корректные данные",
                textField: textField
            )
            return
        }
        
        
        switch textField {
            case redTextField:
            redColor.setValue(currentValue, animated: true)
            setValue(for: redColorValue)
            case greenTextField:
            greenColor.setValue(currentValue, animated: true)
            setValue(for: greenColorValue)
            case blueTextField:
            blueColor.setValue(currentValue, animated: true)
            setValue(for: blueColorValue)
            default:
                break
        }
        
        setColor()
    }
}

