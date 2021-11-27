//
//  Extensions.swift
//  ToDo
//
//  Created by Kemal Sanlı on 25.11.2021.
//

import Foundation
import UIKit

//Source: https://stackoverflow.com/a/27079103
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//Source: https://github.com/i0sa/CodezillaFiles/blob/master/LocalizationExtension.swift
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
