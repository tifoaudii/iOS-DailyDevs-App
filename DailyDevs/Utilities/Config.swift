//
//  Config.swift
//  DailyDevs
//
//  Created by Tifo Audi Alif Putra on 26/02/19.
//  Copyright © 2019 BCC FILKOM. All rights reserved.
//

import Foundation
import Firebase

//BASE_DB
let DB_BASE = Database.database().reference()
let _REF_BASE = DB_BASE
let _REF_USERS = DB_BASE.child("users")
let _REF_FEEDS = DB_BASE.child("feeds")
let _REF_GROUPS = DB_BASE.child("groups")
