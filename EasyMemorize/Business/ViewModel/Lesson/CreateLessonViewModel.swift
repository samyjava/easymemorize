//
//  CreateLessonViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit
import RxSwift
import Action

struct CreateLessonViewModel: ModifyLessonViewModelType {
    let sceneCoordinator: SceneCoordinatorType
    let lessonService: LessonServiceType
    
    init(sceneCoordinator: SceneCoordinatorType, lessonService: LessonServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.lessonService = lessonService
    }
    
    func create() -> Action<NewLesson,Void> {
        return Action { lesson -> Observable<Void> in
            return self.lessonService.createLesson(title: lesson.title, image: lesson.image, language: lesson.language).do(onError: { error in
                throw error
            }, onCompleted: {
                self.sceneCoordinator.pop()
            }).asObservable().map{_ in}
        }
    }
}
