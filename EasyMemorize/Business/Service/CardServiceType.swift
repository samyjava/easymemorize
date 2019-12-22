//
//  CardServiceType.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/9/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RxSwift

enum CardServiceError: Error {
    case creationFailed
    case editationFailed(CardItem)
    case deletionFailed(CardItem)
}

protocol CardServiceType {
    @discardableResult
    func createCard(word: String, definition: String, Lesson: LessonItem) -> Completable
    
    @discardableResult
    func edit(card: CardItem, word: String?, definition: String?, lesson: LessonItem?) -> Observable<CardItem>
    
    @discardableResult
    func delete(card: CardItem) -> Completable
}
