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
    
    convenience init(word: String, definition: String, Lesson: LessonItem) {
        self.init()
        self.word = word
        self.definition = definition
        self.lesson = Lesson
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
