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
            let subject = PublishSubject<Void>()
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We are about to login") { success, error in
                if success {
                    DispatchQueue.main.async {
                        let tabBarViewModel = TabBarViewModel(sceneCoordinator: self.sceneCoordinator)
                        self.sceneCoordinator.sceneTransition(to: .tabBar(viewModel: tabBarViewModel), type: .root).do(onError: { error in
                            throw error
                        })}
                    subject.onCompleted()
                } else {
                    subject.onError(LoginViewModelError.biometricAuthenticationFailed)
                }
            }
            return subject.asObserver()
        }
    }
    
    func loginWay() -> Single<LoginWayItem> {
        self.userService.fetchUser().do(onSuccess: { user in
            if user.loginWay == LoginWayItem.none {
                let tabBarViewModel = TabBarViewModel(sceneCoordinator: self.sceneCoordinator)
                let testLesson = LessonService()
                let testbox = BoxService()
                let testCard = CardService()
                self.sceneCoordinator.createTabBar(lessonService: testLesson, boxService: testbox, cardService: testCard)
                self.sceneCoordinator.sceneTransition(to: .tabBar(viewModel: tabBarViewModel), type: .root)
            }
        }).map{$0.loginWay}
    }
}
