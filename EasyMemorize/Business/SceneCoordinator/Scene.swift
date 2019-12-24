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
    case createCard(viewModel: CreateCardViewModel)
    case showCards(viewModel: ShowCardsViewModel)
    case showBoxCards(viewModel: ShowBoxCardsViewModel)
}
