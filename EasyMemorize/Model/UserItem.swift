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
    var logInWay: LogInWayItem!
    
    convenience init(userName: String, logInWay: LogInWayItem, prsImage: String? = nil) {
        self.init()
        self.userName = userName
        self.logInWay = logInWay
        self.prsImage = prsImage
    }
    
}
