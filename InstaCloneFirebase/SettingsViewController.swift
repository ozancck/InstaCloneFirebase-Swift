//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by Ozan Çiçek on 31.10.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        performSegue(withIdentifier: "toViewControllerVC", sender: nil)
    }
    
}
