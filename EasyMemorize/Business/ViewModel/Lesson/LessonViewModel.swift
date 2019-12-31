//
//  LessonViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/29/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import Action

struct LessonViewModel {
    let sceneCoordinator: SceneCoordinatorType
    let boxService: BoxServiceType
    let cardService: CardServiceType
    let lesson: LessonItem
    
    init(sceneCoordinator: SceneCoordinatorType, boxService: BoxServiceType, cardService: CardServiceType,lesson: LessonItem) {
        self.sceneCoordinator = sceneCoordinator
        self.boxService = boxService
        self.cardService = cardService
        self.lesson = lesson
    }
    
    func createCard() -> CocoaAction {
        return CocoaAction {
            let createCardViewModel = CreateCardViewModel(sceneCoordinator: self.sceneCoordinator, cardService: self.cardService)
            return self.sceneCoordinator.sceneTransition(to: .createCard(viewModel: createCardViewModel), type: .modal).asObservable().map{_ in}
        }
    }
    
    func play() -> CocoaAction {
        return CocoaAction {
            let showCardsViewModel = ShowCardsViewModel(sceneCoordinator: self.sceneCoordinator, cards: self.lesson.cards.toArray(), boxService: self.boxService)
            return self.sceneCoordinator.sceneTransition(to: .showCards(viewModel: showCardsViewModel), type: .push).asObservable().map{_ in}
        }
    }
    
    func edit(cardItem: CardItem) -> CocoaAction {
        return CocoaAction {
            let editCardViewModel = EditCardViewModel(sceneCoordinator: self.sceneCoordinator, cardService: self.cardService, card: cardItem)
            return self.sceneCoordinator.sceneTransition(to: .editCard(viewModel: editCardViewModel), type: .modal).asObservable().map{_ in}
        }
    }
    
}
