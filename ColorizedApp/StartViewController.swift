//
//  StartViewController.swift
//  ColorizedApp
//
//  Created by Anzhelika on 07.11.25.
//

import UIKit

protocol ColorPaleteViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

class StartViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVC = segue.destination as? ColorPaleteViewController else {
            return
        }
            colorVC.delegate = self
            colorVC.viewColor = view.backgroundColor
        }
}

extension StartViewController: ColorPaleteViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
