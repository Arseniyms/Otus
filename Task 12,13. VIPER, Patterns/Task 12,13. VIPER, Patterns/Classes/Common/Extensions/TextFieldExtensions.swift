//
//  Extensions.swift
//  EventPasser
//
//  Created by Arseniy Matus on 17.10.2022.
//

import UIKit

extension UITextField {
    func setBorderStyle(autocorrectionType: UITextAutocorrectionType = .yes, autocapitalizationType: UITextAutocapitalizationType = .sentences) {
        borderStyle = .roundedRect
        layer.cornerRadius = 4.0
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.borderWidth = 0.5

        self.autocorrectionType = autocorrectionType
        self.autocapitalizationType = autocapitalizationType
    }
}
