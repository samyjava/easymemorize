//
//  Tab+ViewController.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit

extension Tab {
    func viewController() -> UIViewController {
        switch self {
            
        case .lessons(let viewModel):
            let storyboard = UIStoryboard(name: "Lesson", bundle: nil)
            let nc = storyboard.instantiateViewController(identifier: "Lessons") as UINavigationController
            var viewController = nc.viewControllers.first as! LessonsViewController
            viewController.bindViewModel(to: viewModel)
            viewController.tabBarItem.title = "Lesson"
            viewController.tabBarItem.image = UIImage(systemName: "book")
            return viewController
            
        case .Box(let viewModel):
            let storyboard = UIStoryboard(name: "Box", bundle: nil)
            let nc = storyboard.instantiateViewController(identifier: "Box") as UINavigationController
            var viewController = nc.viewControllers.first as! BoxViewController
            viewController.bindViewModel(to: viewModel)
            viewController.tabBarItem.title = "Leithner Box"
            viewController.tabBarItem.image = UIImage(systemName: "cube.box")
            return viewController
        }
    }
}
