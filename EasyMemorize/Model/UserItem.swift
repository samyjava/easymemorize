//
//  UserItem.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/8/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation

class UserItem: Codable {
    var userName: String!
    var loginWay: LoginWayItem!
    var prsImage: String?
    var password: String?
    
    private init() {}
    
    init(userName: String, loginWay: LoginWayItem, prsImage: String? = nil, password: String? = nil) {
        self.userName = userName
        self.loginWay = loginWay
        self.prsImage = prsImage
        self.password = password
    }
    
    enum CodingKeys: CodingKey {
        case userName
        case loginWay
        case prsImage
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.userName = try values.decode(String.self, forKey: .userName)
        self.loginWay = try values.decode(LoginWayItem.self, forKey: .loginWay)
        self.prsImage = try values.decode(String.self, forKey: .prsImage)
    }
    
}
