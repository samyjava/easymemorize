//
//  ShowCardsViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit
import RxSwift
import Action

enum ShowCardsViewModelError: Error {
    case cardIsExistInBox
}

struct ShowCardsViewModel {
    let sceneCoordinator: SceneCoordinatorType
    let cards: [CardItem]
    let boxService: BoxServiceType
    
    init(sceneCoordinator: SceneCoordinatorType, cards: [CardItem], boxService: BoxServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.cards = cards
        self.boxService = boxService
    }
    
    func sendToLeithnerBox() -> Action<CardItem,Void> {
        return Action { card -> Observable<Void> in
            self.boxService.isExistCardInBoxes(card: card).map { isExist in
                if isExist {
                    throw ShowCardsViewModelError.cardIsExistInBox
                } else {
                    self.boxService.transferCardTo(box: 1, card: card)
                }
            }.asObservable().map{_ in}
        }
    }
}
