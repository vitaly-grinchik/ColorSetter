//
//  ColorSetterViewController.swift
//  ColorSetter
//
//  Created by Виталий Гринчик on 24.11.22.
//

import UIKit

class ColorSetterViewController: UIViewController {

    // MARK: - IB Outlets
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
    
    // MARK: - Public properties
    var currentColor: UIColor!
    var delegate: ColorSetterViewControllerDelegate! // Создаем экземпляр протокола, этакая "ссылка" на другой класс, где реализуются методы протокла
    
    // MARK: - Private
    private var textFiledPreviousValue = "" // "Buffer" to store textfiled value before it's going to be cleared

    private enum ColorComponent {
        case red, green, blue
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()   // Initial UI setup
        updateBoxColor()
    }
    
    // Remove keyboard if not needed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func sliderMoved(_ sender: UISlider) {
        let newValue = CGFloat(sender.value)
        switch sender {
        case redSlider:
            updateCurrentColor(for: .red, on: newValue)
            update(redValueLabel)
            update(redValueTextField)

        case greenSlider:
            updateCurrentColor(for: .green, on: newValue)
            update(greenValueLabel)
            update(greenValueTextField)

        default:
            updateCurrentColor(for: .blue, on: newValue)
            update(blueValueLabel)
            update(blueValueTextField)
        }
        updateBoxColor()
    }
  
    @IBAction func doneButtonTapped() {
        delegate.setBackgroundColor(currentColor) // вызываем метод протокола
        dismiss(animated: true)
    }
    
    // MARK: - Private methods
    private func setupUI() {
        
        setupColorBox()
        setupSliders()
        setupTextFeilds()
        
       // Set init values
        [redValueLabel,
         redSlider,
         redValueTextField,
         
         greenValueLabel,
         greenSlider,
         greenValueTextField,
         
         blueValueLabel,
         blueSlider,
         blueValueTextField].forEach { update($0) }
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
    
    private func getString(for value: CGFloat) -> String {
        String(format: "%.2f", value)
    }
    
    
    private func update(_ view: Any?) {

        switch view {
        case let label as UILabel:
            switch label {
            case redValueLabel:
                redValueLabel.text = getString(for: currentColor.redValue)
            case greenValueLabel:
                greenValueLabel.text = getString(for: currentColor.greenValue)
            default:
                blueValueLabel.text = getString(for: currentColor.blueValue)
            }
        
        case let slider as UISlider:
            switch slider {
            case redSlider:
                redSlider.setValue(Float(currentColor.redValue), animated: true)
            case greenSlider:
                greenSlider.setValue(Float(currentColor.greenValue), animated: true)
            default:
                blueSlider.setValue(Float(currentColor.blueValue), animated: true)
            }
            
        case let textField as UITextField:
            switch textField {
            case redValueTextField:
                redValueTextField.text = getString(for: currentColor.redValue)
            case greenValueTextField:
                greenValueTextField.text = getString(for: currentColor.greenValue)
            default:
                blueValueTextField.text = getString(for: currentColor.blueValue)
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
        [redValueTextField, greenValueTextField, blueValueTextField].forEach {
            $0?.delegate = self
            $0?.keyboardType = .decimalPad
            $0?.clearsOnBeginEditing = true
            
            if let textField = $0 {
                addKeyboardToolBar(for: textField)
            }
        }
    }
}

// MARK: - ColorSetterViewController
// Add keyboard tool bar
extension ColorSetterViewController {
    private func addKeyboardToolBar(for textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(keyboardDoneButonTapped))
           
        keyboardToolBar.items = [space, doneButton]
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
    }
    
    @objc private func keyboardDoneButonTapped() {
        view.endEditing(true)
    }
}

// MARK: - UIColor
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

// MARK: - UITextFieldDelegate
extension ColorSetterViewController: UITextFieldDelegate {
    
    // To memorize current textfield value before its editing
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textFiledPreviousValue = textField.text ?? ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Prevent to enter invalid value
        let newValue = Double(textField.text ?? "") ?? 2
        
        // Check for correct value filled in
        if newValue > 1 {
            textField.text = textFiledPreviousValue
            return
        }
        
        switch textField {
        case redValueTextField:
            updateCurrentColor(for: .red, on: CGFloat(newValue))
            update(redValueLabel)
            update(redSlider)
            update(redValueTextField)
        case greenValueTextField:
            updateCurrentColor(for: .green, on: CGFloat(newValue))
            update(greenValueLabel)
            update(greenSlider)
            update(greenValueTextField)
        default:
            updateCurrentColor(for: .blue, on: CGFloat(newValue))
            update(blueValueLabel)
            update(blueSlider)
            update(blueValueTextField)
        }
        updateBoxColor()
    }
}


