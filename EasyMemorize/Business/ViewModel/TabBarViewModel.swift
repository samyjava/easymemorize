//
//  TabBarViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit
import Action

struct TabBarViewModel {
    let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
    
    func onSwitchTab() -> Action<Int,Void> {
        return Action { index in
            self.sceneCoordinator.switchTab(to: index).asObservable().map {_ in}
        }
    }
}
