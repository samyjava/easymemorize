//
//  BoxService.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/10/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

struct BoxService: BoxServiceType {
    
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
    
    func createBox(no: Int, waitingTime: TimeInterval) -> Completable {
        let result = withRealm(title: "Create Box") { realm -> Completable in
            let box = BoxItem(boxNumber: no, waitingTime: waitingTime)
            try realm.write {
                box.id = (realm.objects(BoxItem.self).max(ofProperty: "id") ?? 0) + 1
                realm.add(box)
            }
            return Completable.empty()
        }
        return result ?? Completable.error(BoxServiceError.creationFailed)
    }
    
    func resetBoxes() -> Completable {
        let result = withRealm(title: "Reset all boxes") { realm -> Completable in
            let boxCardItems = realm.objects(BoxCardItem.self)
            try realm.write {
                realm.delete(boxCardItems)
            }
            return Completable.empty()
        }
        return result ?? Completable.error(BoxServiceError.resetFailed)
    }
    
    func transferCardTo(box no:Int, card: CardItem) -> Completable {
        let result = withRealm(title: "Transition Card") { realm -> Completable in
            guard let cardExist = realm.objects(BoxCardItem.self).filter("cardId == \(card.id)").first else{
                return Completable.error(BoxServiceError.transferFailed(card))
            }
            try realm.write {
                cardExist.boxId = no
                cardExist.addDate = Date()
            }
            return Completable.empty()
        }
        return result ?? Completable.error(BoxServiceError.transferFailed(card))
    }
    
    
}
