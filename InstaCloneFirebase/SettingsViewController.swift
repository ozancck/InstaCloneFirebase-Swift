//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by Ozan Çiçek on 31.10.2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewControllerVC", sender: nil)
        }catch {
            print("error")
        }
    }
    
}
