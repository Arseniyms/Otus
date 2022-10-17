//
//  Color.swift
//  Task 10. Table view
//
//  Created by Arseniy Matus on 16.10.2022.
//

import UIKit


struct Color {
    var name: String
    var UICol: UIColor
}

extension String {
    func firstLetterUppercased() -> String {
        self.prefix(1).uppercased() + self.dropFirst()
    }
}
