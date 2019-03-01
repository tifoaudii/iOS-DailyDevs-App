//
//  AuthVC.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 28/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: LOGIN_WITH_EMAIL_SEGUE, sender: nil)
    }
    
    @IBAction func loginWithFacebook(_ sender: Any) {
    }
    
    @IBAction func loginWithGoogle(_ sender: Any) {
    }
    
}
