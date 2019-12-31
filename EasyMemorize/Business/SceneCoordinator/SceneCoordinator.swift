//
//  SceneCoordinator.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit
import RxSwift

enum SceneCoordinatorError: String, Error {
    case noNavigationController = "There isn't any NavigationController found."
    case noTabBarController = "There isn't any TabBarController found."
    case noValidTab = "This tab doesn't exist."
    case popNotValid = "Pop isn't valid."
}

class SceneCoordinator: SceneCoordinatorType {
    
    private var window: UIWindow!
    private var currentViewController: UIViewController!
    private var pushDepth = 0
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func sceneTransition(to scene: Scene, type: TransitionType) -> Completable {
        switch type {
        case .root:
            let viewController = scene.viewController()
            self.window.rootViewController = viewController
            self.currentViewController = viewController
            return Completable.empty()
            
        case .modal:
            let viewController = scene.viewController()
            self.currentViewController.present(viewController, animated: true, completion: nil)
            self.currentViewController = viewController
            return Completable.empty()
            
        case .push:
            guard let navigationController = self.currentViewController.navigationController else {
                return Completable.error(SceneCoordinatorError.noNavigationController)
            }
            let viewController = scene.viewController()
            navigationController.pushViewController(viewController, animated: true)
            self.currentViewController = viewController
            self.pushDepth += 1
            navigationController.tabBarController?.tabBar.isHidden = true
            return Completable.empty()
        }
    }
    
    func switchTab(to tabIndex: Int) -> Completable {
        guard let tabBarController = self.currentViewController.tabBarController else {
            return Completable.error(SceneCoordinatorError.noTabBarController)
        }
        guard tabIndex >= 0, tabIndex < Tab.tabs.count else {
            return Completable.error(SceneCoordinatorError.noValidTab)
        }
        tabBarController.selectedIndex = tabIndex
        self.currentViewController = tabBarController.viewControllers![tabIndex]
        return Completable.empty()
    }
    
    func pop() -> Completable {
        if let presenter = self.currentViewController.presentingViewController {
            self.currentViewController.dismiss(animated: true, completion: nil)
            self.currentViewController = presenter
            return Completable.empty()
        } else if let navigationController = self.currentViewController.navigationController {
            navigationController.popViewController(animated: true)
            self.currentViewController = navigationController.visibleViewController
            self.pushDepth -= 1
            if self.pushDepth == 0 {
                navigationController.tabBarController?.tabBar.isHidden = false
            }
            return Completable.empty()
        } else {
            return Completable.error(SceneCoordinatorError.popNotValid)
        }
    }
    
    func createTabBar(lessonService: LessonServiceType, boxService: BoxServiceType, cardService: CardServiceType) -> Completable {
        // Create ViewModels
        let lessonsViewModel = LessonsViewModel(sceneCoordinator: self, lessonService: lessonService, boxService: boxService, cardService: cardService)
        let boxViewModel = BoxViewModel(sceneCoordinator: self, boxService: boxService)
        // Create Tabs
        let lessonTab = Tab.lessons(viewModel: lessonsViewModel)
        let boxTab = Tab.Box(viewModel: boxViewModel)

        Tab.tabs.append(contentsOf: [lessonTab, boxTab])
        return Completable.empty()
    }
    
    
}
