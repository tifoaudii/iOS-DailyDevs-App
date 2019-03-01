//
//  TabBarVC.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 28/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstTab = FeedVC()
        let secondTab = GroupsVC()
        
        firstTab.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "close"), tag: 0)
        secondTab.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "compose"), tag: 1)
        
        let tabBarList = [firstTab, secondTab]
        viewControllers = tabBarList
        
    }
}
