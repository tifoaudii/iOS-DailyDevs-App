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
    var postArray = [Post]()
    
    //GET REF DB
    var REF_BASE: DatabaseReference { return _REF_BASE }
    var REF_USER: DatabaseReference { return _REF_USERS }
    var REF_GROUP: DatabaseReference { return _REF_GROUPS }
    var REF_FEED: DatabaseReference { return _REF_FEEDS }
    
    //SERVICES TO FIREBASE
    func createUser(uid: String, userAccount: Dictionary<String,Any>) {
        REF_USER.child(uid).updateChildValues(userAccount)
    }
    
    func createNewPost(withMessage message: String, fromUID uid: String, groupKey key: String, completion: @escaping (_ status: Bool )-> ()) {
        
        if key !=  "" {
            
        }else {
            REF_FEED.childByAutoId().updateChildValues(["content" : message, "senderID": uid])
            completion(true)
        }
    }
    
    func getUserName(uid: String ,completion: @escaping (_ userName: String) -> ()) {
        REF_USER.observeSingleEvent(of: .value) { (userData) in
            guard let userSnapshot = userData.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                if user.key == uid {
                    completion(user.childSnapshot(forPath: "email").value as! String)
                }
             }
        }
    }
    
    func fetchAllPosts(completion: @escaping (_ status: Bool) -> ()) {
        postArray.removeAll()
        REF_FEED.observeSingleEvent(of: .value) { (feedSnapshot) in
            guard let feedSnapshot = feedSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for feed in feedSnapshot {
                let content = feed.childSnapshot(forPath: "content").value as! String
                let senderId = feed.childSnapshot(forPath: "senderID").value as! String
                
                let newPost = Post(content: content, senderId: senderId)
                self.postArray.append(newPost)
            }
            
            completion(true)
        }
    }
    
}
