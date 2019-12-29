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
import LocalAuthentication

enum LoginViewModelError: Error {
    case authenticationFailed
    case biometricAuthenticationFailed
}

struct LoginViewModel {
    let sceneCoordinator: SceneCoordinatorType
    let userService: UserServiceType
    
    init(sceneCoordinator: SceneCoordinatorType, userService: UserServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.userService = userService
    }
    
    func authenticate() -> Action<String,Void> {
        return Action { password -> Observable<Void> in
            self.userService.athenticate(password: password).do(onError: {_ in
                throw LoginViewModelError.authenticationFailed
            }, onCompleted: {
                let tabBarViewModel = TabBarViewModel(sceneCoordinator: self.sceneCoordinator)
                self.sceneCoordinator.sceneTransition(to: .tabBar(viewModel: tabBarViewModel), type: .root)
            }).asObservable().map{_ in}
        }
    }
    
    
    func detectBiometric() -> CocoaAction {
        return CocoaAction {
            let context = LAContext()
            var loginSuccess = false
            var loginError: Error?
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We are about to login") { success, error in
                loginSuccess = success
                loginError = error
            }
            guard loginSuccess, loginError == nil else {
                return Observable<Void>.error(LoginViewModelError.biometricAuthenticationFailed)
            }
            let tabBarViewModel = TabBarViewModel(sceneCoordinator: self.sceneCoordinator)
            return self.sceneCoordinator.sceneTransition(to: .tabBar(viewModel: tabBarViewModel), type: .root).do(onError: { error in
                throw error
            }).asObservable().map{_ in}
        }
    }
}
