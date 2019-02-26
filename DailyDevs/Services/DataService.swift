//
//  DataService.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 26/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let instance = DataService()
    
    //GET REF DB
    var REF_BASE: DatabaseReference { return _REF_BASE }
    var REF_USER: DatabaseReference { return _REF_USERS }
    var REF_GROUP: DatabaseReference { return _REF_GROUPS }
    var REF_FEED: DatabaseReference { return _REF_FEEDS }
    
    //SERVICES TO FIREBASE
    func createUser(uid: String, userAccount: Dictionary<String,Any>) {
        REF_USER.child(uid).updateChildValues(userAccount)
    }
}
