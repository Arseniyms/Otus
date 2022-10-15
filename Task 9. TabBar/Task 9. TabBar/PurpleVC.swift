//
//  PurpleVC.swift
//  Task 9. TabBar
//
//  Created by Arseniy Matus on 14.10.2022.
//

import UIKit

class PurpleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Purple appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Purple disappear")
        super.viewDidDisappear(animated)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            print("Purple destroy")
        }
    }

}
