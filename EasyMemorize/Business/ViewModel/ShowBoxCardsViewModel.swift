//
//  ShowBoxCardsViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit
import RxSwift
import Action

struct ShowBoxCardsViewModel {
    let sceneCoordinator: SceneCoordinatorType
    let boxService: BoxServiceType
    let cards: [CardItem]
    let boxId: Int
    
    init(sceneCoordinator: SceneCoordinatorType, boxService: BoxServiceType, cards: [CardItem], boxId: Int) {
        self.sceneCoordinator = sceneCoordinator
        self.boxService = boxService
        self.cards = cards
        self.boxId = boxId
    }
    
    func iKnow() -> Action<CardItem,Void> {
        return Action {card -> Observable<Void> in
            self.boxService.transferCardTo(box: (self.boxId + 1), card: card).asObservable().map {_ in}
        }
    }
    
    func iDontKnow() -> Action<CardItem,Void> {
        return Action {card -> Observable<Void> in
            self.boxService.transferCardTo(box: 1, card: card).asObservable().map {_ in}
        }
    }
}
