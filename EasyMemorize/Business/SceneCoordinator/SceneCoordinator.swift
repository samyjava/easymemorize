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
    
    func sceneTransition(to scene: Scene, type: TransitionType) throws {
        switch type {
        case .root:
            let viewController = scene.viewController()
            self.window.rootViewController = viewController
            self.currentViewController = viewController
            
        case .modal:
            let viewController = scene.viewController()
            self.currentViewController.present(viewController, animated: true, completion: nil)
            self.currentViewController = viewController
            
        case .push:
            guard let navigationController = self.currentViewController.navigationController else {
                throw SceneCoordinatorError.noNavigationController
            }
            let viewController = scene.viewController()
            navigationController.pushViewController(viewController, animated: true)
            self.currentViewController = viewController
            self.pushDepth += 1
            navigationController.tabBarController?.tabBar.isHidden = true
        }
    }
    
    func switchTab(to tab: Tab) throws {
        guard let tabBarController = self.currentViewController.tabBarController else {
            throw SceneCoordinatorError.noTabBarController
        }
        guard let index = Tab.tabs.firstIndex(of: tab) else {
            throw SceneCoordinatorError.noValidTab
        }
        tabBarController.selectedIndex = index
        self.currentViewController = tabBarController.viewControllers![index]
    }
    
    func pop() throws {
        if let presenter = self.currentViewController.presentingViewController {
            self.currentViewController.dismiss(animated: true, completion: nil)
            self.currentViewController = presenter
        } else if let navigationController = self.currentViewController.navigationController {
            navigationController.popViewController(animated: true)
            self.currentViewController = navigationController.visibleViewController
            self.pushDepth -= 1
            if self.pushDepth == 0 {
                navigationController.tabBarController?.tabBar.isHidden = false
            }
        } else {
            throw SceneCoordinatorError.popNotValid
        }
    }
    
    func createTabBar() throws {
        // Create ViewModels
        let dashboardViewModel = DashboardViewModel()
        let lessonViewModel = LessonViewModel()
        let boxViewModel = BoxViewModel()
        // Create Tabs
        let dashboardTab = Tab.dashboard(viewModel: dashboardViewModel)
        let lessonTab = Tab.lesson(viewModel: lessonViewModel)
        let boxTab = Tab.Box(viewModel: boxViewModel)

        Tab.tabs.append(contentsOf: [dashboardTab, lessonTab, boxTab])
    }
    
    
}
