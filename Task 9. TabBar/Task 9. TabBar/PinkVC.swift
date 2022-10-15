//
//  PinkVC.swift
//  Task 9. TabBar
//
//  Created by Arseniy Matus on 14.10.2022.
//

import UIKit

class PinkVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    

    @IBAction func goBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Pink appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Pink disappear")
        super.viewDidDisappear(animated)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            print("pink destroy")
        }
    }

}
