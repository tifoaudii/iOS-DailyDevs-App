//
//  GroupFeedCell.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 04/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPost: UILabel!
    
    func setupCell(profileImage image: String, userName name: String, userPost post: String) {
        self.profileImage.image = UIImage(named: image)
        self.userName.text = name
        self.userPost.text = post
    }
    
}
