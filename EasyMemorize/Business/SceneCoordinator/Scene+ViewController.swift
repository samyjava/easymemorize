//
//  Scene+ViewController.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/23/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import UIKit

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        //case .splash:
            
        case .register(let viewModel):
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "Register") as RegisterViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .login(let viewModel):
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "Login") as LoginViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .createLesson(let viewModel):
            let storyboard = UIStoryboard(name: "Lesson", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "CreateLesson") as CreateLessonViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .editLesson(let viewModel):
            let storyboard = UIStoryboard(name: "Lesson", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "CreateLesson") as CreateLessonViewController
            viewController.isEditing = true
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .createCard(let viewModel):
            let storyboard = UIStoryboard(name: "Card", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "CreateEditCard") as CreateCardViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .editCard(let viewModel):
            let storyboard = UIStoryboard(name: "Card", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "CreateEditCard") as CreateCardViewController
            viewController.isEditMode = true
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .showCards(let viewModel):
            let storyboard = UIStoryboard(name: "Card", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "ShowCards") as ShowCardsViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .showBoxCards(let viewModel):
            let storyboard = UIStoryboard(name: "Box", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "ShowBoxCards") as ShowBoxCardsViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
            
        case .tabBar(let viewModel):
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "TabBar") as TabBarViewController
            var temViewControllers = [UIViewController]()
            Tab.tabs.forEach {
                temViewControllers.append($0.viewController())
            }
            viewController.viewControllers = temViewControllers
            viewController.bindViewModel(to: viewModel)
            return viewController
            
            case .lesson(let viewModel):
            let storyboard = UIStoryboard(name: "Lesson", bundle: nil)
            var viewController = storyboard.instantiateViewController(identifier: "Lesson") as LessonViewController
            viewController.bindViewModel(to: viewModel)
            return viewController
        }
    }
}
