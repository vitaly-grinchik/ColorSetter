//
//  ViewController.swift
//  ColorSetter
//
//  Created by Виталий Гринчик on 24.11.22.
//

import UIKit

class ViewController: UIViewController {

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
    // Buttons
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: - Private properties
    private let initialSlidersValue: Float = 0.3
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init view of color box
        colorBoxView.layer.borderColor = UIColor.black.cgColor
        colorBoxView.layer.borderWidth = 4
        colorBoxView.layer.cornerRadius = 15
        
        setupSlidersWithValue(initialSlidersValue)
        updateUI()
    }
    
    // MARK: - IB Actions
    @IBAction func sliderMoved() {
        updateUI()
    }
    
    @IBAction func resetButtonTapped() {
        setupSlidersWithValue(initialSlidersValue)
        updateUI()
    }
    
    // MARK: - Private methods
    private func getFormatedValueString(of value: Float) -> String {
        
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 2
        
        let valueFormated = formater.string(from: NSNumber(value: value)) ?? ""
        
        return valueFormated
    }
    
    private func updateUI() {
        let currentColor = UIColor(
            cgColor: CGColor(
                red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1.0
            )
        )
        colorBoxView.backgroundColor = currentColor     // Update box color

        // Update color value labels and box color
        redValueLabel.text = getFormatedValueString(of: redSlider.value)
        greenValueLabel.text = getFormatedValueString(of: greenSlider.value)
        blueValueLabel.text = getFormatedValueString(of: blueSlider.value)
    }
    
    private func setupSlidersWithValue(_ value: Float) {
        redSlider.value = value
        greenSlider.value = value
        blueSlider.value = value
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
}
