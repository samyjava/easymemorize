//
//  UserService.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/25/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift



struct UserService: UserServiceType {
    
    func create(user: UserItem) -> Completable {
        guard !user.userName.isEmpty else {
            return Completable.error(UserServiceError.creationFailed)
        }
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: "UserDataInfo")
            // check for password and save on keychain
            
            fatalError()
            
            return Completable.empty()
        } catch {
            return Completable.error(UserServiceError.creationFailed)
        }
    }
    
    func athenticate(password: String) -> Completable {
        fatalError()
    }
    
    func edit(user: UserItem, userName: String?, prsImage: String?, loginWay: LoginWayItem?) -> Completable {
        fatalError()
    }
    
    func delete(user: UserItem) -> Completable {
        fatalError()
    }
    
    
}
