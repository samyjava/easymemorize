//
//  ModifyLessonViewModelType.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/30/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation

struct NewLesson {
    let title: String
    let image: String?
    let language: String
}

struct EditedLesson {
    let title: String?
    let image: String?
    let language: String?
}

protocol ModifyLessonViewModelType {
    
}
