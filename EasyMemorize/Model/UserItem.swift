//
//  UserItem.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/8/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation

class UserItem {
    var prsImage: String?
    var userName: String!
    var loginWay: LogInWayItem!
    
    init(userName: String, loginWay: LogInWayItem, prsImage: String? = nil) {
        self.userName = userName
        self.loginWay = loginWay
        self.prsImage = prsImage
    }
    
}
