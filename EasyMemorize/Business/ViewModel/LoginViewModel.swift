//
//  LoginViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RxSwift
import Action

enum LoginViewModelError: Error {
    case authenticationFailed
}

struct LoginViewModel {
    let sceneCoordinator: SceneCoordinatorType!
    let userService: UserServiceType!
    
    init(sceneCoordinator: SceneCoordinatorType, userService: UserServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.userService = userService
    }
    
    func authenticate() -> Action<String,Void> {
        return Action { password -> Observable<Void> in
            self.userService.athenticate(password: password).do(onError: {_ in
                throw LoginViewModelError.authenticationFailed
            }, onCompleted: {
                let tabBarViewModel = TabBarViewModel()
                self.sceneCoordinator.sceneTransition(to: .tabBar(viewModel: tabBarViewModel), type: .root)
            }).asObservable().map{_ in}
        }
    }
}
