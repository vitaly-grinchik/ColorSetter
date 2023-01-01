//
//  StartViewController.swift
//  ColorSetter
//
//  Created by Виталий Гринчик on 30.12.22.
//

import UIKit

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
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let colorSetterVC = segue.source as? ColorSetterViewController else { return }
        currentBackGroundColor = colorSetterVC.currentColor
        view.backgroundColor = currentBackGroundColor
    }
}
