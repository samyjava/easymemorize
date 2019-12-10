//
//  LessonService.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/9/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

struct LessonService: LessonServiceType {
    
    private func withRealm<T>(title: String, action: (Realm) throws -> T) -> T? {
        do {
            let realm = try Realm()
            return try action(realm)
        }
        catch let error {
            print("Failed during \(title) with error: \(error)")
            return nil
        }
    }
    
    
    func createLesson(title: String, image: String?, language: String) -> Completable {
        let result = withRealm(title: "Create Lesson") { realm -> Completable in
            let lesson = LessonItem(title: title, language: language)
            if let image = image {
                lesson.image = image
            }
            try realm.write {
                lesson.id = (realm.objects(LessonItem.self).max(ofProperty: "id") ?? 0 ) + 1
                realm.add(lesson)
            }
            return Completable.empty()
        }
        return result ?? Completable.error(LessonServiceError.creationFailed)
    }
    
    func edit(lesson: LessonItem, title: String?, image: String?, language: String?) -> Completable {
        let result = withRealm(title: "Edit Lesson") { realm -> Completable in
            try realm.write {
                if let title = title {
                    lesson.title = title
                }
                if let image = image {
                    lesson.image = image
                }
                if let language = language {
                    lesson.language = language
                }
            }
            return Completable.empty()
        }
        return result ?? Completable.error(LessonServiceError.editationFailed)
    }
    
    func delete(lesson: LessonItem) -> Completable {
        let result = withRealm(title: "Delete Lesson") { realm -> Completable in
            try realm.write {
                realm.delete(lesson)
            }
            return Completable.empty()
        }
        return result ?? Completable.error(LessonServiceError.deletionFailed(lesson))
    }
    
    func fetchAllLesson() -> Observable<Results<LessonItem>> {
        let result = withRealm(title: "Fetch all lesson") { realm -> Observable<Results<LessonItem>> in
            let lessons = realm.objects(LessonItem.self).filter("id != 0")
            return Observable.collection(from: lessons)
        }
        return result ?? Observable.error(LessonServiceError.fetchFailed)
    }
    
    func assign(card: CardItem, to lesson: LessonItem) -> Completable {
        let result = withRealm(title: "Assign card to lesson") { realm -> Completable in
            try realm.write {
                card.lesson = lesson
            }
            return Completable.empty()
        }
        return result ?? Completable.error(LessonServiceError.assignationFailed(lesson))
    }
    
    func getCards(by lessonId: Int) -> Observable<[CardItem]> {
        let result = withRealm(title: "Get cards") { realm -> Observable<[CardItem]> in
                if let lesson = realm.objects(LessonItem.self).filter("id == \(lessonId)").first {
                    let cards = lesson.cards.toArray()
                    return Observable.just(cards)
                } else {
                    return Observable.error(LessonServiceError.fetchFailed)
            }
        }
        return result ?? Observable.error(LessonServiceError.fetchFailed)
    }
}
