//
//  UserFeedCell.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 04/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class UserFeedCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPost: UILabel!
    
    func setupCell(userName: String, userPost: String) {
        self.userName.text = userName
        self.userPost.text = userPost
    }
    
}
