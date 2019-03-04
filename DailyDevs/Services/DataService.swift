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
    
    func createNewPost(withMessage message: String, fromUID uid: String, groupKey key: String, completion: @escaping (_ status: Bool )-> ()) {
        
        if key !=  "" {
            REF_GROUP.child(key).child("messages").childByAutoId().updateChildValues(["content" : message, "senderID": uid])
            completion(true)
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
    
    func fetchAllPosts(completion: @escaping (_ status: [Post]) -> ()) {
        var postArray = [Post]()
        REF_FEED.observeSingleEvent(of: .value) { (feedSnapshot) in
            guard let feedSnapshot = feedSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for feed in feedSnapshot {
                let content = feed.childSnapshot(forPath: "content").value as! String
                let senderId = feed.childSnapshot(forPath: "senderID").value as! String
                
                let newPost = Post(content: content, senderId: senderId)
                postArray.append(newPost)
            }
            postArray.reverse()
            completion(postArray)
        }
    }
    
    func fetchPostFromGroup(fromGroup group: Group, completion: @escaping (_ posts: [Post]) -> ()) {
        var postArray = [Post]()
        REF_GROUP.child(group.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
            guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for groupMessage in groupMessageSnapshot {
                let content = groupMessage.childSnapshot(forPath: "content").value as! String
                let senderId = groupMessage.childSnapshot(forPath: "senderID").value as! String
                let newPost = Post(content: content, senderId: senderId)
                postArray.append(newPost)
            }
            completion(postArray)
        }
        
    }
    func searchUserEmail(withQuery query: String, completion: @escaping (_ emails: [String]) -> ()) {
        var filteredEmails = [String]()
        
        REF_USER.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) && (Auth.auth().currentUser?.email?.contains(query))! == false {
                    filteredEmails.append(email)
                }
            }
            
            completion(filteredEmails)
        }
    }
    
    func getUserID(fromUserEmails userEmails: [String], completion: @escaping (_ listId: [String])->()) {
        var listId = [String]()
        
        REF_USER.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if userEmails.contains(email) {
                    listId.append(user.key)
                }
            }
            completion(listId)
        }
    }
    
    func createGroup(groupName title: String, groupDesc desc: String, groupMember members: [String], completion: @escaping (_ status: Bool)->()) {
        
        let group = [
            "title": title,
            "description": desc,
            "members": members
            ] as [String : Any]
        
        REF_GROUP.childByAutoId().updateChildValues(group)
        completion(true)
    }
    
    func fetchAllGroup(completion: @escaping (_ groups: [Group]) ->()) {
        var groupArray = [Group]()
        REF_GROUP.observeSingleEvent(of: .value) { (groupSnapshot) in
            guard let groupSnapshot = groupSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for group in groupSnapshot {
                let name = group.childSnapshot(forPath: "title").value as! String
                let desc = group.childSnapshot(forPath: "description").value as! String
                let member = group.childSnapshot(forPath: "members").value as! [String]
                let currentUserUid = Auth.auth().currentUser?.uid
                
                if member.contains(currentUserUid!) {
                    let newGroup = Group(forName: name, withDesc: desc, withKey: group.key, andMember: member)
                    groupArray.append(newGroup)
                }
            }
            completion(groupArray)
        }
    }
    
}
