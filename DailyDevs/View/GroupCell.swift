//
//  GroupCell.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 03/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupDesc: UILabel!
    @IBOutlet weak var groupMember: UILabel!
    
    func setupCell(groupName name: String, groupDesc desc: String, groupMember member: Int) {
        self.groupName.text = name
        self.groupMember.text = "\(member) member"
        self.groupDesc.text = desc
    }
}
