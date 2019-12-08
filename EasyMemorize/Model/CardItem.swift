//
//  CardItem.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/8/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class CardItem: Object {
    dynamic var id: Int = 0
    dynamic var word: String!
    dynamic var definition: String!
    dynamic var lesson: LessonItem!
    dynamic var timeInsertToBox: Date?
    
    convenience init(word: String, definition: String, Lesson: LessonItem, timeInsertToBox: Date? = nil) {
        self.init()
        self.word = word
        self.definition = definition
        self.lesson = Lesson
        self.timeInsertToBox = timeInsertToBox
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
