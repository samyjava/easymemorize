//
//  LessonViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import Action
import RxSwift

struct LessonsViewModel {
    let sceneCoordinator: SceneCoordinatorType
    let lessonService: LessonServiceType
    
    init(sceneCoordinator: SceneCoordinatorType, lessonService: LessonServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.lessonService = lessonService
    }
    
    func show(lesson item: LessonItem) -> CocoaAction {
        return CocoaAction {
            let lessonViewModel = LessonViewModel()
            return self.sceneCoordinator.sceneTransition(to: .lesson(viewModel: lessonViewModel), type: .push).asObservable().map{_ in}
        }
    }
    
    func create() -> CocoaAction {
        return CocoaAction {
            let createLessonViewModel = CreateLessonViewModel(sceneCoordinator: self.sceneCoordinator, lessonService: self.lessonService)
            return self.sceneCoordinator.sceneTransition(to: .createLesson(viewModel: createLessonViewModel), type: .modal).asObservable().map{_ in}
        }
    }
    
    func allLessons() -> Observable<[LessonItem]> {
        return self.lessonService.fetchAllLesson()
    }
    
    func edit(lesson item: LessonItem) -> CocoaAction {
        return CocoaAction {
            let editLessonViewModel = EditLessonViewModel()
            return self.sceneCoordinator.sceneTransition(to: .editLesson(viewModel: editLessonViewModel), type: .modal).asObservable().map{_ in}
        }
    }
}
