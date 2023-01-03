//
//  StartViewController.swift
//  ColorSetter
//
//  Created by Виталий Гринчик on 30.12.22.
//

import UIKit

protocol ColorSetterViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor)
}

class StartViewController: UIViewController {

    @IBOutlet var setColorButton: UIButton!
    
    var currentBackGroundColor: UIColor! = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColorButton.backgroundColor = .white
        view.backgroundColor = currentBackGroundColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSetterVC = segue.destination as? ColorSetterViewController else { return }
        colorSetterVC.currentColor = currentBackGroundColor
        
    }
}

// MARK: - ColorSetterViewControllerDelegate
extension StartViewController: ColorSetterViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = currentBackGroundColor
    }
}
