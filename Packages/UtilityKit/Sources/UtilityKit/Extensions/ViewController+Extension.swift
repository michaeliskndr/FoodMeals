//
//  File.swift
//  
//
//  Created by Michael Iskandar on 10/01/24.
//

import UIKit

public extension UIViewController {
    func showFailedAlert() {
        let alert = UIAlertController(title: "Error", message: "Error occured", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
