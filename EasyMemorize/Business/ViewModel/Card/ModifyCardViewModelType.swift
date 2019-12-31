//
//  ModifyCardViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/31/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation

struct NewCard {
    let word: String
    let definition: String
    let lesson: LessonItem
}

struct EditedCard {
    let word: String?
    let definition: String?
}

protocol ModifyCardViewModelType {
    
}
