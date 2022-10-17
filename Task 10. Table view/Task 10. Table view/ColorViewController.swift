//
//  ColorViewController.swift
//  Task 10. Table view
//
//  Created by Arseniy Matus on 16.10.2022.
//

import UIKit

class ColorViewController: UIViewController {
    var color = Color(name: "", UICol: .white)
    var goBackButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color.UICol
        self.navigationItem.title = color.name.firstLetterUppercased()
        setUpButton()
    }
    
    func setUpButton() {
        goBackButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(goBackButton)
        goBackButton.setTitle("Go back", for: .normal)
        goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        NSLayoutConstraint.activate([
            goBackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            goBackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func goBack(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }

}
