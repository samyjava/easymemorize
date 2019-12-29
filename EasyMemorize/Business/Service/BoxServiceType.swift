//
//  BoxServiceType.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/10/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RxSwift

enum BoxServiceError: Error {
    case creationFailed
    case transferFailed(CardItem)
    case resetFailed
    case isExistingFailed
}


protocol BoxServiceType {
    @discardableResult
    func createBox(no: Int, waitingTime: TimeInterval) -> Completable
    
    @discardableResult
    func resetBoxes() -> Completable
    
    @discardableResult
    func transferCardTo(box no:Int, card: CardItem) -> Completable
    
    @discardableResult
    func isExistCardInBoxes(card: CardItem) -> Single<Bool>
}
