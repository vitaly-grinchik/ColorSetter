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
    
    // MARK: - Private properties
    private let initialSlidersValue: Float = 0.5
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init view of color box
        colorBoxView.layer.borderColor = UIColor.systemBlue.cgColor
        colorBoxView.layer.borderWidth = 4
        colorBoxView.layer.cornerRadius = 15
        // Init view of sliders
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        resetSliders()
        updateBoxColor()
    }
    
    // MARK: - IB Actions
    @IBAction func sliderMoved(_ sender: UISlider) {
        updateBoxColor()
        updateValueLabelFor(sender)
    }
    
    @IBAction func resetButtonTapped() {
        resetSliders()
        updateBoxColor()
    }
    
    // MARK: - Private methods
    private func updateBoxColor() {
        let currentColor = UIColor(
            cgColor: CGColor(
                red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1.0
            )
        )
        colorBoxView.backgroundColor = currentColor
    }
    
    private func updateValueLabelFor(_ slider: UISlider) {
        switch slider {
        case redSlider: redValueLabel.text = String(format: "%.2f", slider.value)
        case greenSlider:  greenValueLabel.text = String(format: "%.2f", slider.value)
        default: blueValueLabel.text = String(format: "%.2f", slider.value)
        }
    }
    
    private func resetSliders() {
        redSlider.value = initialSlidersValue
        greenSlider.value = initialSlidersValue
        blueSlider.value = initialSlidersValue
        
        updateValueLabelFor(redSlider)
        updateValueLabelFor(greenSlider)
        updateValueLabelFor(blueSlider)
    }
}
