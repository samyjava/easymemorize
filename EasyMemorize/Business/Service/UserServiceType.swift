//
//  UserServiceType.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/25/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum UserServiceError: Error {
    case creationFailed
    case editationFailed
    case deletionFailed(UserItem)
    case fetchFailed
}

protocol UserServiceType {
    @discardableResult
    func create(userName: String, prsImage: String?, loginWay: LogInWayItem?) -> Completable
    
    @discardableResult
    func athenticate(password: String) -> Completable
    
    @discardableResult
    func edit(user: UserItem, userName: String?, prsImage: String?, loginWay: LogInWayItem?) -> Completable
    
    @discardableResult
    func delete(user: UserItem) -> Completable
}
