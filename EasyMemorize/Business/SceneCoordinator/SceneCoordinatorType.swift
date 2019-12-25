//
//  SceneCoordinatorType.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/10/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    func sceneTransition(to scene: Scene, type: TransitionType) throws
    func switchTab(to tab: Tab) throws
    func pop() throws
    func createTabBar() throws
}
