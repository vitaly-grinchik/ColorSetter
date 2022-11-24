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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSliders()
        setBoxColor()
    }
    
    @IBAction func sliderMoved() {
        setBoxColor()
    }
    
    private func getCurrentColor() -> UIColor {
        return UIColor(cgColor: CGColor(
                red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1.0
            )
        )
    }
    
    private func setBoxColor() {
        colorBoxView.layer.borderColor = UIColor.black.cgColor
        colorBoxView.layer.borderWidth = 4
        colorBoxView.layer.cornerRadius = 15
        colorBoxView.backgroundColor = getCurrentColor()
    }
    
    private func setupSliders() {
        redSlider.value = 0
        greenSlider.value = 0
        blueSlider.value = 0
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
    }
}

