//
//  Group.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 04/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation
struct Group {
    public private(set) var key: String
    public private(set) var name: String
    public private(set) var desc: String
    public private(set) var member: [String]
    
    init(forName name: String, withDesc desc: String, withKey key: String, andMember member: [String]) {
        self.name = name
        self.desc = desc
        self.member = member
        self.key = key
    }
}
