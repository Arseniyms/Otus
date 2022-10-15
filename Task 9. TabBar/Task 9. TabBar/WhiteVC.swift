//
//  WhiteVC.swift
//  Task 9. TabBar
//
//  Created by Arseniy Matus on 14.10.2022.
//

import UIKit

class WhiteVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onBackToRedTapped(_ sender: Any) {
        performSegue(withIdentifier: "goToRoot", sender: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("White appear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("White disappear")
        super.viewDidDisappear(animated)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            print("White destroy")
        }
    }
    
}
