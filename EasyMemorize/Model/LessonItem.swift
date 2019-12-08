//
//  LessonItem.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/8/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class LessonItem: Object {
    dynamic var id: Int = 0
    dynamic var title: String!
    dynamic var language: String!
    dynamic var image: String?
    let cards = LinkingObjects(fromType: CardItem.self, property: "lesson")
    
    convenience init(title: String, language: String, image: String? = nil) {
        self.init()
        self.title = title
        self.language = language
        self.image = image
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
