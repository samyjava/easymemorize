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
    @discardableResult
    func sceneTransition(to scene: Scene, type: TransitionType) -> Completable
    
    @discardableResult
    func switchTab(to tab: Tab) -> Completable
    
    @discardableResult
    func pop() -> Completable
    
    @discardableResult
    func createTabBar() -> Completable
}
