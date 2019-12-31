//
//  EditCardViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/31/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import Action
import RxSwift


struct EditCardViewModel: ModifyCardViewModelType {
    let sceneCoordinator: SceneCoordinatorType
    let cardService: CardServiceType
    let card: CardItem
    
    init(sceneCoordinator: SceneCoordinatorType, cardService: CardServiceType, card: CardItem) {
        self.sceneCoordinator = sceneCoordinator
        self.cardService = cardService
        self.card = card
    }
    
    func save() -> Action<EditedCard,Void> {
        return Action { editedCard in
            return self.cardService.edit(card: self.card, word: editedCard.word, definition: editedCard.definition, lesson: nil).asObservable().map{_ in}
        }
    }
    
    func showCard() -> Single<CardItem> {
        return Single.just(self.card)
    }
    
    func cancel() -> CocoaAction {
        return CocoaAction {
            self.sceneCoordinator.pop().asObservable().map{_ in}
        }
    }
}
