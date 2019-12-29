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
            
        case .lesson(let viewModel):
            let storyboard = UIStoryboard(name: "Lesson", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "Lesson") as LessonViewController
            viewController.bindViewModel(to: viewModel)
            viewController.tabBarItem.title = "Lesson"
            viewController.tabBarItem.image = UIImage(systemName: "book")
            return viewController
            
        case .Box(let viewModel):
            let storyboard = UIStoryboard(name: "Box", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "Box") as BoxViewController
            viewController.bindViewModel(to: viewModel)
            viewController.tabBarItem.title = "Leithner Box"
            viewController.tabBarItem.image = UIImage(systemName: "cube.box")
            return viewController
        }
    }
}
