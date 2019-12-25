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
            
        case .dashboard(let viewModel):
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "Dashboard") as DashboardViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .lesson(let viewModel):
            let storyboard = UIStoryboard(name: "Lesson", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "Lesson") as LessonViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .Box(let viewModel):
            let storyboard = UIStoryboard(name: "Box", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "Box") as BoxViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
        }
    }
}