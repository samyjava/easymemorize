//
//  Scene.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/23/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation

enum Scene {
    //case splash
    case register(viewModel: RegisterViewModel)
    case login(viewModel: LoginViewModel)
    case createLesson(viewModel: CreateLessonViewModel)
    case editLesson(viewModel: EditLessonViewModel)
    case createCard(viewModel: CreateCardViewModel)
    case editCard(viewModel: EditCardViewModel)
    case showCards(viewModel: ShowCardsViewModel)
    case showBoxCards(viewModel: ShowBoxCardsViewModel)
    case tabBar(viewModel: TabBarViewModel)
    case lesson(viewModel: LessonViewModel)
}
