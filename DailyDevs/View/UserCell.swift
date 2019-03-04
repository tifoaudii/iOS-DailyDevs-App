//
//  UserCell.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 03/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    var showingCheckImage = false
    
    
    func setupCell(profileImage image: String, userName name: String, isSelected: Bool) {
        self.profileImage.image = UIImage(named: image)
        self.userName.text = name
        if isSelected {
            checkImage.isHidden = false
        } else {
            checkImage.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showingCheckImage {
                checkImage.isHidden = true
                showingCheckImage = false
            } else {
                checkImage.isHidden = false
                showingCheckImage = true
            }
        }
        
    }

}
