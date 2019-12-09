//
//  LessonServiceType.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/9/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum LessonServiceError: Error {
    case creationFailed
    case editationFailed
    case deletionFailed(LessonItem)
    case fetchFailed(LessonItem)
    case assignationFailed(LessonItem)
}

protocol LessonServiceType {
    @discardableResult
    func createLesson(title: String, image: String?, language: String) -> Completable
    
    @discardableResult
    func editLesson(lesson: LessonItem, title: String?, image: String?, language: String?) -> Completable
    
    @discardableResult
    func deleteLesson(lesson: LessonItem) -> Completable
    
    @discardableResult
    func fetchAllLesson() -> Observable<[LessonItem]>
    
    @discardableResult
    func assign(card: CardItem, to lesson: LessonItem) -> Completable
}
