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
    // implement this func correctly
    func athenticate(password: String) -> Completable {
        return Completable.error(UserServiceError.creationFailed)
    }
    
    func edit(user: UserItem, userName: String?, prsImage: String?, loginWay: LoginWayItem?) -> Completable {
        fatalError()
    }
    
    func delete(user: UserItem) -> Completable {
        fatalError()
    }
    
    func fetchUser() -> Single<UserItem> {
        let userTemp = UserItem(userName: "zgjhghzdj", loginWay: .none)
        return Single.just(userTemp)
        guard let userData = UserDefaults.standard.data(forKey: "UserDataInfo") else {
            return Single.error(UserServiceError.fetchFailed)
        }
        do {
         let user = try JSONDecoder().decode(UserItem.self, from: userData)
            return Single.just(user)
        } catch {
            return Single.error(UserServiceError.fetchFailed)
        }
    }
    
}
