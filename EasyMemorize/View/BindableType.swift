//
//  BindableType.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/23/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit

protocol BindableType {
    associatedtype ViewModelType
    var viewModel: ViewModelType! {get set}
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    mutating func bindViewModel(to viewModel: ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        self.bindViewModel()
    }
}
