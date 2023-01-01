//
//  ColorSetterViewController.swift
//  ColorSetter
//
//  Created by Виталий Гринчик on 24.11.22.
//

import UIKit

class ColorSetterViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var colorBoxView: UIView!
    // Slider values
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    // Sliders
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    // Text Fields
    @IBOutlet var redValueTextField: UITextField!
    @IBOutlet var greenValueTextField: UITextField!
    @IBOutlet var blueValueTextField: UITextField!
    
    var currentColor: UIColor!
    
    private enum ColorComponent: CaseIterable {
        case red, green, blue
    }
       
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    
        [redValueLabel,
         redSlider,
         redValueTextField,
         
         greenValueLabel,
         greenSlider,
         greenValueTextField,
         
        blueValueLabel,
        blueSlider,
        blueValueTextField].forEach { updateUIElement($0) }
    }
    
    // Remove keyboard if not needed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderMoved(_ sender: UISlider) {
        switch sender {
        case redSlider:
            updateCurrentColor(for: .red, on: CGFloat(sender.value))
            updateUIElement(redValueLabel)
            updateUIElement(redValueTextField)
        case greenSlider:
            updateCurrentColor(for: .green, on: CGFloat(sender.value))
            updateUIElement(greenValueLabel)
            updateUIElement(greenValueTextField)
        default:
            updateCurrentColor(for: .blue, on: CGFloat(sender.value))
            updateUIElement(blueValueLabel)
            updateUIElement(blueValueTextField)
        }
        updateBoxColor()
    }
  
    // MARK: - Private methods
    private func setupUI() {
        updateBoxColor()
        setupColorBox()
        setupSliders()
        setupTextFeilds()
    }
    
    private func updateBoxColor() {
        colorBoxView.backgroundColor = currentColor
    }
    
    private func updateCurrentColor(for component: ColorComponent, on value: CGFloat) {
        var newColor = UIColor()
        switch component {
        case .red: newColor = UIColor(red: value,
                                      green: currentColor.greenValue,
                                      blue: currentColor.blueValue,
                                      alpha: currentColor.alpha)

        case .green: newColor = UIColor(red: currentColor.redValue,
                                        green: value,
                                        blue: currentColor.blueValue,
                                        alpha: currentColor.alpha)

        default: newColor = UIColor(red: currentColor.redValue,
                                    green: currentColor.greenValue,
                                    blue: value,
                                    alpha: currentColor.alpha)
        }
        currentColor = newColor
    }
    
    private func updateUIElement(_ element: Any?) {

        switch element {
        case let label as UILabel:
            switch label {
            case redValueLabel:
                redValueLabel.text = String(format: "%.2f", currentColor.redValue)
            case greenValueLabel:
                greenValueLabel.text = String(format: "%.2f", currentColor.greenValue)
            default:
                blueValueLabel.text = String(format: "%.2f", currentColor.blueValue)
            }
        
        case let slider as UISlider:
            switch slider {
            case redSlider: redSlider.value = Float(currentColor.redValue)
            case greenSlider: greenSlider.value = Float(currentColor.greenValue)
            default: blueSlider.value = Float(currentColor.blueValue)
            }
            
        case let textField as UITextField:
            switch textField {
            case redValueTextField: redValueTextField.text = String(format: "%.2f", currentColor.redValue)
            case greenValueTextField:  greenValueTextField.text = String(format: "%.2f", currentColor.greenValue)
            default: blueValueTextField.text = String(format: "%.2f", currentColor.blueValue)
            }
        default: break
        }
    }
    
    // Setup views
    private func setupColorBox() {
        colorBoxView.layer.borderColor = UIColor.white.cgColor
        colorBoxView.layer.borderWidth = 4
        colorBoxView.layer.cornerRadius = 15
    }
    
    private func setupSliders() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
    
    private func setupTextFeilds() {
        [redValueTextField, greenValueTextField, blueValueTextField].forEach { textFiled in
            textFiled?.delegate = self
            textFiled?.keyboardType = .decimalPad
            textFiled?.clearsOnBeginEditing = true
        }
    }
}


// MARK: - UITextFieldDelegate
extension ColorSetterViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        let newValue = CGFloat(Float(textField.text ?? "0.00") ?? 0)
        
        switch textField {
        case redValueTextField:
            updateCurrentColor(for: .red, on: newValue)
            updateUIElement(redValueLabel)
            updateUIElement(redSlider)
    
        case greenValueTextField:
            updateCurrentColor(for: .green, on: newValue)
            updateUIElement(greenValueLabel)
            updateUIElement(greenSlider)
        default:
            updateCurrentColor(for: .blue, on: newValue)
            updateUIElement(blueValueLabel)
            updateUIElement(blueSlider)
        }
        updateBoxColor()
    }
}

// MARK: - ColorSetterViewController
private extension UIColor {
    var redValue: CGFloat {
        CIColor(color: self).red
    }
    var greenValue: CGFloat {
        CIColor(color: self).green
    }
    var blueValue: CGFloat {
        CIColor(color: self).blue
    }
    var alpha: CGFloat {
        CIColor(color: self).alpha
    }
}
