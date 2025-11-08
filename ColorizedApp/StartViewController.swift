//
//  StartViewController.swift
//  ColorizedApp
//
//  Created by Anzhelika on 07.11.25.
//

import UIKit

protocol ColorPaleteViewControllerDelegate: AnyObject {
    func setBackgroundColor(_ color: UIColor)
}

class StartViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let colorVC = segue.destination as? ColorPaleteViewController {
                colorVC.delegate = self
            }
        }
}

extension StartViewController: ColorPaleteViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
