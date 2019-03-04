//
//  AddGroupVC.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 03/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit
import Firebase

class AddGroupVC: UIViewController {

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupDescTextField: UITextField!
    @IBOutlet weak var groupMemberTextField: UITextField!
    @IBOutlet weak var groupMemberTableView: UITableView!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var createGroupButton: UIButton!
    
    var filteredUserName = [String]()
    var chosenUserName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupMemberTableView.delegate = self
        groupMemberTableView.dataSource = self
        groupMemberTextField.delegate = self
        groupMemberTextField.addTarget(self, action: #selector(AddGroupVC.onGroupNameChanged), for: .editingChanged)
    }
    
    @IBAction func closeView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func onGroupNameChanged() {
        let query = groupMemberTextField.text
        if query == "" {
            filteredUserName = []
            groupMemberTableView.reloadData()
        } else {
            DataService.instance.searchUserEmail(withQuery: query!) { (result) in
                self.filteredUserName = result
                self.groupMemberTableView.reloadData()
            }
        }
    }
    
    @IBAction func onCreateGroup(_ sender: Any) {
        let groupName = groupNameTextField.text
        let groupDesc = groupDescTextField.text
        var groupMember = [String]()
        let currentUserUid = Auth.auth().currentUser?.uid
        
        if groupName != "" && groupDesc != "" {
            DataService.instance.getUserID(fromUserEmails: chosenUserName) { (userId) in
                groupMember = userId
                groupMember.append(currentUserUid!)
                
                DataService.instance.createGroup(groupName: groupName!, groupDesc: groupDesc!, groupMember: groupMember, completion: { (success) in
                    if success {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
}

extension AddGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUserName.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: USER_CELL, for: indexPath) as? UserCell {
            if chosenUserName.contains(filteredUserName[indexPath.row]) {
                cell.setupCell(profileImage: "defaultProfileImage", userName: filteredUserName[indexPath.row], isSelected: true)
            }else {
                cell.setupCell(profileImage: "defaultProfileImage", userName: filteredUserName[indexPath.row], isSelected: false)
            }
            return cell
        } else {
            return UserCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        
        let username = cell.userName.text!
        
        if !chosenUserName.contains(username) {
            chosenUserName.append(username)
            groupLabel.text = chosenUserName.joined(separator: ",")
            createGroupButton.isHidden = false
        } else {
            chosenUserName = chosenUserName.filter({ (currentName) -> Bool in
                currentName != username
            })
            if chosenUserName.count > 0 {
                groupLabel.text = chosenUserName.joined(separator: ",")
            } else {
                groupLabel.text = "Add person to groups"
                createGroupButton.isHidden = true
            }
        }
    }

}

extension AddGroupVC: UITextFieldDelegate {}
