//
//  Post.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 02/03/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation
struct Post {
    public private(set) var content: String
    public private(set) var senderId: String
    
    init(content: String, senderId: String) {
        self.content = content
        self.senderId = senderId
    }
}
