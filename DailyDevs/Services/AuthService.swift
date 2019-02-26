//
//  AuthService.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 26/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, registerComplete: @escaping (_ status: Bool, _ error: Error?)->()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                registerComplete(false, error)
                return
            }
            
            let userData = [
                "provider" : result.user.providerID,
                "email" : result.user.email
            ]
            
            DataService.instance.createUser(uid: result.user.uid, userAccount: userData as Dictionary<String, Any>)
            registerComplete(true,nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping(_ status: Bool, _ error: Error?) -> ()) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                loginComplete(false, error)
                return
            }
            
            loginComplete(true,nil)
        }
    }
}
