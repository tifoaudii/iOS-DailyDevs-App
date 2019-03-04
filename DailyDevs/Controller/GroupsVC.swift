//
//  SecondViewController.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 26/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class GroupsVC: UIViewController {

    @IBOutlet weak var groupTableView: UITableView!
    private var listGroup = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataService.instance.fetchAllGroup { (result) in
            self.listGroup = result
            self.groupTableView.reloadData()
        }
    }

}

extension GroupsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGroup.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GROUP_CELL, for: indexPath) as? GroupCell {
            let group = listGroup[indexPath.row]
            cell.setupCell(groupName: group.name, groupDesc: group.desc, groupMember: group.member.count)
            return cell
        } else {
            return GroupCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let GroupFeedVC = storyboard?.instantiateViewController(withIdentifier: "group_feed_vc") as? GroupFeedVC else { return }
        GroupFeedVC.loadGroup(currentGroup: listGroup[indexPath.row])
        presentDetail(GroupFeedVC)
    }
    
}

