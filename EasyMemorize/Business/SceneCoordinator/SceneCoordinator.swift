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
    
    func switchTab(to tab: Tab) -> Completable {
        guard let tabBarController = self.currentViewController.tabBarController else {
            return Completable.error(SceneCoordinatorError.noTabBarController)
        }
        guard let index = Tab.tabs.firstIndex(of: tab) else {
            return Completable.error(SceneCoordinatorError.noValidTab)
        }
        tabBarController.selectedIndex = index
        self.currentViewController = tabBarController.viewControllers![index]
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
    
    func createTabBar() -> Completable {
        // Create ViewModels
        let lessonViewModel = LessonViewModel()
        let boxViewModel = BoxViewModel()
        // Create Tabs
        let lessonTab = Tab.lesson(viewModel: lessonViewModel)
        let boxTab = Tab.Box(viewModel: boxViewModel)

        Tab.tabs.append(contentsOf: [lessonTab, boxTab])
        return Completable.empty()
    }
    
    
}
