//
//  MyCell.swift
//  Task 10. Table view
//
//  Created by Arseniy Matus on 16.10.2022.
//

import UIKit

class MyCell: UITableViewCell {
    let colorLabel = UILabel()
    
    override func didMoveToSuperview() {
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(colorLabel)
        NSLayoutConstraint.activate([
            colorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            colorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setColor(color: String) {
        colorLabel.text = color.firstLetterUppercased()
    }
}
