//
//  CardService.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/9/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

struct CardService: CardServiceType {
    
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
    
    func createCard(word: String, definition: String, Lesson: LessonItem) -> Completable {
        let result = withRealm(title: "Create Card") { realm -> Completable in
            let card = CardItem(word: word, definition: definition, Lesson: Lesson)
            try realm.write {
                card.id = (realm.objects(CardItem.self).max(ofProperty: "id") ?? 0 ) + 1
                realm.add(card)
            }
            return Completable.empty()
        }
        return result ?? Completable.error(CardServiceError.creationFailed)
    }
    
    func edit(card: CardItem, word: String?, definition: String?) -> Observable<CardItem> {
        let result = withRealm(title: "Edit Card") { realm -> Observable<CardItem> in
            try realm.write {
                if let word = word {
                    card.word = word
                }
                if let definition = definition {
                    card.definition = definition
                }
            }
            return Observable.just(card)
        }
        return result ?? Observable.error(CardServiceError.editationFailed(card))
    }
    
    func delete(card: CardItem) -> Completable {
        let result = withRealm(title: "Delete Card") { realm -> Completable in
            try realm.write {
                realm.delete(card)
            }
            return Completable.empty()
        }
        return result ?? Completable.error(CardServiceError.deletionFailed(card))
    }
    
    
}
