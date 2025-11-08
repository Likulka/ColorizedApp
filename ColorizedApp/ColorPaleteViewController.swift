//
//  ViewController.swift
//  Lesson 2.4 Знакомство с фреймворком UIKit. Работа с документацией
//
//  Created by Anzhelika on 06.10.25.
//

import UIKit

final class ColorPaleteViewController: UIViewController {

    @IBOutlet var colorPalete: UIView!
    
    @IBOutlet var redColor: UISlider!
    @IBOutlet var greenColor: UISlider!
    @IBOutlet var blueColor: UISlider!
    
    @IBOutlet var redColorValue: UILabel!
    @IBOutlet var greenColorValue: UILabel!
    @IBOutlet var blueColorValue: UILabel!
    
    @IBOutlet var doneButton: UIButton!
    
    weak var delegate: ColorPaleteViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorPalete.layer.cornerRadius = 10
        
        colorPalete.backgroundColor = UIColor(
            red: CGFloat(redColor.value),
            green: CGFloat(greenColor.value),
            blue: CGFloat(blueColor.value),
            alpha: 1.0)
        
        redColorValue.text = string(from: redColor)
        greenColorValue.text = string(from: greenColor)
        blueColorValue.text = string(from: blueColor)        
    }
    
    @IBAction private func changeColor(_ sender: UISlider) {
        switch sender {
        case redColor:
            redColorValue.text = string(from: redColor)
        case greenColor:
            greenColorValue.text = string(from: greenColor)
        default:
            blueColorValue.text = string(from: blueColor)
        }
        
        colorPalete.backgroundColor = UIColor(
            red: CGFloat(redColor.value),
            green: CGFloat(greenColor.value),
            blue: CGFloat(blueColor.value),
            alpha: 1.0)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        delegate?.setBackgroundColor(
            UIColor(
            red: CGFloat(redColor.value),
            green: CGFloat(greenColor.value),
            blue: CGFloat(blueColor.value),
            alpha: 1.0)
        )
        dismiss(animated: true)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    

}

