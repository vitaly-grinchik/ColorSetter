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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorSetterVC = segue.destination as? ColorSetterViewController else { return }
        colorSetterVC.currentColor = view.backgroundColor
        colorSetterVC.delegate = self // инициализация делегата перед переходом экземпляром собственного класса - self - который подписан под протокол делегата
    }
}

// MARK: - ColorSetterViewControllerDelegate
extension StartViewController: ColorSetterViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
