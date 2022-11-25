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
    private let initialSlidersValue: Float = 0.3
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init view of color box
        colorBoxView.layer.borderColor = UIColor.black.cgColor
        colorBoxView.layer.borderWidth = 4
        colorBoxView.layer.cornerRadius = 15
        
        setupSlidersWithValue()
        updateBoxColor()
    }
    
    // MARK: - IB Actions
    @IBAction func sliderMoved() {
        updateBoxColor()
        updateSliderValueLabels()
    }
    
    @IBAction func resetButtonTapped() {
        setupSlidersWithValue()
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
    
    private func updateSliderValueLabels() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    private func setupSlidersWithValue() {
        redSlider.value = initialSlidersValue
        greenSlider.value = initialSlidersValue
        blueSlider.value = initialSlidersValue
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
}
