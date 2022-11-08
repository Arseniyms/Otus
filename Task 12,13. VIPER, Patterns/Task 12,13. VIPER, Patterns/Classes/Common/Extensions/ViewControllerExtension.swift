//
//  LabelExtensions.swift
//  EventPasser
//
//  Created by Arseniy Matus on 20.10.2022.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    func getInfoTextLabel(of info: String) -> UITextField {
        let textField = UITextField()
        textField.text = info
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.setBorderStyle()
        textField.delegate = self

        return textField
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
