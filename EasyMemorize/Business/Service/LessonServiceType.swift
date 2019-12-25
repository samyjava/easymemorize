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
    case fetchFailed
    case assignationFailed(LessonItem)
}

protocol LessonServiceType {
    @discardableResult
    func createLesson(title: String, image: String?, language: String) -> Completable
    
    @discardableResult
    func edit(lesson: LessonItem, title: String?, image: String?, language: String?) -> Completable
    
    @discardableResult
    func delete(lesson: LessonItem) -> Completable
    
    @discardableResult
    func fetchAllLesson() -> Observable<Results<LessonItem>>
}
