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
    let boxService: BoxServiceType
    let cardService: CardServiceType
    
    init(sceneCoordinator: SceneCoordinatorType, lessonService: LessonServiceType, boxService: BoxServiceType, cardService: CardServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.lessonService = lessonService
        self.boxService = boxService
        self.cardService = cardService
    }
    
    func show(lesson item: LessonItem) -> CocoaAction {
        return CocoaAction {
            let lessonViewModel = LessonViewModel(sceneCoordinator: self.sceneCoordinator, boxService: self.boxService, cardService: self.cardService, lesson: item)
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
