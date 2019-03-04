//
//  GroupFeedVC.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 04/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupFeedTableView: UITableView!
    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    private var currentGroup: Group?
    private var groupMessage = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupFeedTableView.delegate = self
        groupFeedTableView.dataSource = self
        groupName.text = currentGroup?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DataService.instance.REF_GROUP.observe(.value) { (snapshot) in
            DataService.instance.fetchPostFromGroup(fromGroup: self.currentGroup!, completion: { (result) in
                self.groupMessage = result
                self.groupFeedTableView.reloadData()
                
                if self.groupMessage.count > 0 {
                    let index = IndexPath(row: self.groupMessage.count - 1, section: 0)
                    self.groupFeedTableView.scrollToRow(at: index, at: .none, animated: true)
                }
            })
        }
    }
    
    func loadGroup(currentGroup group: Group) {
        self.currentGroup = group
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func sendPost(_ sender: Any) {
        let message = postTextField.text
        let uid = Auth.auth().currentUser?.uid
        let key = currentGroup!.key
        if message != "" {
            sendBtn.isEnabled = false
            postTextField.isEnabled = false
            DataService.instance.createNewPost(withMessage: message!, fromUID: uid!, groupKey: key) { (success) in
                if success {
                    self.sendBtn.isEnabled = true
                    self.postTextField.isEnabled = true
                    self.postTextField.text = ""
                    self.groupFeedTableView.reloadData()
                }
            }
        }
    
    }
}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessage.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_FEED_CELL, for: indexPath) as? GroupFeedCell {
            let post = groupMessage[indexPath.row]
            DataService.instance.getUserName(uid: post.senderId) { (result) in
                cell.setupCell(profileImage: "defaultProfileImage", userName: result, userPost: post.content)
            }
            return cell
        } else {
            return GroupFeedCell()
        }
    }
}
