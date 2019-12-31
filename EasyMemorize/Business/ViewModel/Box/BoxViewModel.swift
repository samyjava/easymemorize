//
//  BoxViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RxSwift
import Action

struct BoxViewModel {
    let sceneCoordinator: SceneCoordinatorType
    let boxService: BoxServiceType
    let bag = DisposeBag()
    
    init(sceneCoordinator: SceneCoordinatorType, boxService: BoxServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.boxService = boxService
    }
    
    func availableCardsCount(in boxNo: Int) -> Observable<Int> {
        self.boxService.availableCards(in: boxNo).map{$0.count}
    }
    
    func allCardsCount(in boxNo: Int) -> Observable<Int> {
        self.boxService.cards(in: boxNo).map{$0.count}
    }
    
    func showCards(in boxNo: Int) -> CocoaAction {
        return CocoaAction {
            self.boxService.availableCards(in: boxNo).subscribe(onNext: { cards in
                if cards.count > 0 {
                    let showBoxCardsViewModel = ShowBoxCardsViewModel(sceneCoordinator: self.sceneCoordinator, boxService: self.boxService, cards: cards, boxId: boxNo)
                    self.sceneCoordinator.sceneTransition(to: .showBoxCards(viewModel: showBoxCardsViewModel), type: .push)
                }
            }).disposed(by: self.bag)
            return Observable.empty()
        }
    }
}
