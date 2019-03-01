//
//  SplashVC.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 28/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit
import Firebase

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser == nil {
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(SplashVC.navigateToLoginVC), userInfo: nil, repeats: false)
        }else {
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(SplashVC.navigateToMainScreen), userInfo: nil, repeats: false)
        }
    }
    
    @objc func navigateToLoginVC() {
        performSegue(withIdentifier: AUTH_SEGUE, sender: nil)
    }
    
    @objc func navigateToMainScreen() {
        performSegue(withIdentifier: MAIN_SEGUE, sender: nil)
    }
}
