//
//  LoginVC.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 28/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoginButtonPressed(_ sender: Any) {
        guard let email = emailTextField.text, emailTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }
        
        self.onLoginUser(withEmail: email, andPassword: password)
    }
    
    private func onLoginUser(withEmail email: String, andPassword password: String) {
        AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success, error) in
            if success {
                print("success")
                self.performSegue(withIdentifier: MAIN_SEGUE, sender: nil)
            } else {
                self.onRegisterUser()
            }
        }
    }
    
    private func onRegisterUser() {
        guard let email = emailTextField.text, emailTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }
        
        AuthService.instance.registerUser(withEmail: email, andPassword: password) { (success, error) in
            if success {
                self.onLoginUser(withEmail: email, andPassword: password)
            } else {
                debugPrint(String.init(describing: error))
            }
        }
    }
    
    @IBAction func dismissLoginVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
