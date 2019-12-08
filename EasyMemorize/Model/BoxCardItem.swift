//
//  BoxCardItem.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/8/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class BoxCardItem:Object {
    dynamic var boxId:Int = 0
    dynamic var cardId:Int = 0
    dynamic var isAvailable:Bool = false
    dynamic var addDate:Date?
    
    override class func primaryKey() -> String {
        return "cardId"
    }
}
