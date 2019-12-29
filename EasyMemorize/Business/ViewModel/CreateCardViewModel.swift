//
//  CreateCardViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit
import RxSwift
import Action

struct NewCard {
    let word: String
    let definition: String
    let lesson: LessonItem
}

struct CreateCardViewModel {
    let sceneCoordinator: SceneCoordinatorType
    let cardService: CardServiceType
    
    init(sceneCoordinator: SceneCoordinatorType, cardService: CardServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.cardService = cardService
    }
    
    func save() -> Action<[NewCard],Void> {
        return Action { cards -> Observable<Void> in
            Observable.from(cards).flatMap{ card in
                self.cardService.createCard(word: card.word, definition: card.definition, Lesson: card.lesson)
            }.do(onError: { error in
                throw error
            }, onCompleted: {
                self.sceneCoordinator.pop()
            }).asObservable().map{_ in}
        }
    }
    
    func cancel() -> CocoaAction {
        return CocoaAction {
            self.sceneCoordinator.pop().asObservable().map{_ in}
        }
    }
}
