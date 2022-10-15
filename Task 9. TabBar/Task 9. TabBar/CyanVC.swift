//
//  CyanVC.swift
//  Task 9. TabBar
//
//  Created by Arseniy Matus on 15.10.2022.
//

import UIKit

class CyanVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goToRootTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Cyan appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Cyan disappear")
        super.viewDidDisappear(animated)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            print("Cyan destroy")
        }
    }
}
