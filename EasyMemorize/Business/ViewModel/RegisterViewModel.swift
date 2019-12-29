//
//  RegisterViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/23/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RxSwift
import Action
import LocalAuthentication


struct RegisterViewModel {
    let sceneCoordinator: SceneCoordinatorType
    let userService: UserServiceType
    
    init(sceneCoordinator: SceneCoordinatorType, userService: UserServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.userService = userService
    }
    
    func register() -> Action<UserItem,Void> {
        return Action { user in
            let tabBarViewModel = TabBarViewModel(sceneCoordinator: self.sceneCoordinator)
            return self.userService.create(user: user).andThen(self.sceneCoordinator.sceneTransition(to: .tabBar(viewModel: tabBarViewModel), type: .root)).asObservable().map{_ in}
        }
    }
    
    func availableLoginWays() -> Observable<[LoginWayItem]> {
        var result: [LoginWayItem] = [.none,.pinLogin]
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error), error == nil {
            if context.biometryType == .faceID {
                result.append(.faceID)
            } else if context.biometryType == .touchID {
                result.append(.fingerID)
            }
        }
        return Observable.just(result)
    }
}
