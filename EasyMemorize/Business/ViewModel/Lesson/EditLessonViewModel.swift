//
//  EditLessonViewModel.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/30/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import Action

struct EditLessonViewModel: ModifyLessonViewModelType {
    let sceneCoordinator: SceneCoordinatorType
    let lessonService: LessonServiceType
    let lesson: LessonItem
    
    init(sceneCoordinator: SceneCoordinatorType, lessonService: LessonServiceType, lesson: LessonItem) {
        self.sceneCoordinator = sceneCoordinator
        self.lessonService = lessonService
        self.lesson = lesson
    }
    
    func save() -> Action<EditedLesson,Void> {
        return Action { editedLesson in
            return self.lessonService.edit(lesson: self.lesson, title: editedLesson.title, image: editedLesson.image, language: editedLesson.language).asObservable().map{_ in}
        }
    }
}
