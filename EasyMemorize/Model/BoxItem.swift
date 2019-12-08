//
//  BoxItem.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/8/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class BoxItem: Object {
    dynamic var id: Int = 0
    dynamic var boxNumber: Int = 0
    dynamic var waitingTime: TimeInterval = 0.0
    
    convenience init(boxNumber: Int, waitingTime: TimeInterval) {
        self.init()
        self.boxNumber = boxNumber
        self.waitingTime = waitingTime
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
