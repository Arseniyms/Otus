//
//  BlueVC.swift
//  Task 9. TabBar
//
//  Created by Arseniy Matus on 14.10.2022.
//

import UIKit

class BlueVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Blue appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("Blue disappear")
        super.viewDidDisappear(animated)
    }
    

}
