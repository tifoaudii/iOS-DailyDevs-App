//
//  ProfileVC.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 01/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postTableView: UITableView!
    
    private var userPost = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = Auth.auth().currentUser?.email
        postTableView.delegate = self
        postTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataService.instance.fetchCurrentUserPost { (result) in
            self.userPost = result.reversed()
            self.postTableView.reloadData()
        }
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (handle) in
            do {
                try Auth.auth().signOut()
                let AuthVC = self.storyboard?.instantiateViewController(withIdentifier: "auth_vc") as? AuthVC
                self.present(AuthVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
    }
}

extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPost.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: USER_FEED_CELL, for: indexPath) as? UserFeedCell {
            let post = userPost[indexPath.row]
            DataService.instance.getUserName(uid: post.senderId) { (result) in
                cell.setupCell(userName: result, userPost: post.content)
            }
            return cell
        } else {
            return UserFeedCell()
        }
    }
    
    
}
