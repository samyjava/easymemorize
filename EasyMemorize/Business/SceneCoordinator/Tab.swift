//
//  Tab.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/23/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation


enum Tab: Equatable {
    
    static var tabs: [Tab] = []
    
    static func ==(lhs: Tab, rhs: Tab) -> Bool {
        switch (lhs,rhs) {
        case (.lessons, .lessons):
            return true
        case (.Box, .Box):
            return true
        default:
            return false
        }
    }
    case lessons(viewModel: LessonsViewModel)
    case Box(viewModel: BoxViewModel)
}
