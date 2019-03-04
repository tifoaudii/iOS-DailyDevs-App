//
//  FirstViewController.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 26/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    private var feedArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataService.instance.fetchAllPosts { (result) in
            self.feedArray = result
            self.feedTableView.reloadData()
        }
    }

    @IBAction func addPostButton(_ sender: Any) {
        
    }
    
}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FEED_CELL, for: indexPath) as? FeedCell {
            let post = feedArray[indexPath.row]
            DataService.instance.getUserName(uid: post.senderId) { (userName) in
                cell.setupCell(profileImage: "defaultProfileImage", userName: userName, userPost: post.content)
            }
            return cell
        }else {
            return FeedCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

