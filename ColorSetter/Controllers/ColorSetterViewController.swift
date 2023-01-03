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
    
    // MARK: - Public properties
    var currentColor: UIColor!
    var delegate: ColorSetterViewControllerDelegate!
    
    // MARK: - Private
    private var textFiledPreviousValue = "" // "Buffer" to store textfiled value before it's going to be cleared

    private enum ColorComponent {
        case red, green, blue
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
            updateUIView(redValueLabel)
            updateUIView(redValueTextField)

        case greenSlider:
            updateCurrentColor(for: .green, on: newValue)
            updateUIView(greenValueLabel)
            updateUIView(greenValueTextField)

        default:
            updateCurrentColor(for: .blue, on: newValue)
            updateUIView(blueValueLabel)
            updateUIView(blueValueTextField)
        }
        updateBoxColor()
    }
  
    @IBAction func doneButtonTapped() {
        delegate.setBackgroundColor(currentColor)
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
         blueValueTextField].forEach { updateUIView($0) }
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
    
    private func updateUIView(_ view: Any?) {

        switch view {
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
            case redSlider:
                redSlider.value = Float(currentColor.redValue)
            case greenSlider:
                greenSlider.value = Float(currentColor.greenValue)
            default:
                blueSlider.value = Float(currentColor.blueValue)
            }
            
        case let textField as UITextField:
            switch textField {
            case redValueTextField:
                redValueTextField.text = String(format: "%.2f", currentColor.redValue)
            case greenValueTextField:
                greenValueTextField.text = String(format: "%.2f", currentColor.greenValue)
            default:
                blueValueTextField.text = String(format: "%.2f", currentColor.blueValue)
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


// MARK: - UITextFieldDelegate
extension ColorSetterViewController: UITextFieldDelegate {
    
    // To memorize current textfield value before its editing
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textFiledPreviousValue = textField.text ?? ""
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Prevent to enter invalid value
        let newValue = CGFloat(Float(textField.text ?? "") ?? 2)
        
        if newValue > 1 {
            textField.text = textFiledPreviousValue
            return
        }
        
        switch textField {
        case redValueTextField:
            updateCurrentColor(for: .red, on: newValue)
            updateUIView(redValueLabel)
            updateUIView(redSlider)
            updateUIView(redValueTextField)
        case greenValueTextField:
            updateCurrentColor(for: .green, on: newValue)
            updateUIView(greenValueLabel)
            updateUIView(greenSlider)
            updateUIView(greenValueTextField)
        default:
            updateCurrentColor(for: .blue, on: newValue)
            updateUIView(blueValueLabel)
            updateUIView(blueSlider)
            updateUIView(blueValueTextField)
        }
        updateBoxColor()
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
