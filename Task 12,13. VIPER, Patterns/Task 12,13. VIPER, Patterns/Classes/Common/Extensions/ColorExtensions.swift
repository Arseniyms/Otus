//
//  ColorExtensions.swift
//  EventPasser
//
//  Created by Arseniy Matus on 18.10.2022.
//

import UIKit

extension UIColor {
    static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(dynamicProvider: {
                switch $0.userInterfaceStyle {
                case .dark:
                    return dark
                case .light, .unspecified:
                    return light
                @unknown default:
                    assertionFailure("Unknown userInterfaceStyle: \($0.userInterfaceStyle)")
                    return light
                }
            })
        }

        // iOS 12 and earlier
        return light
    }
}
