//
//  Scene+ViewController.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/23/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import Foundation
import UIKit

extension Scene {
    func viewController() -> UIViewController {
        switch self {
        //case .splash:
            
        case .register:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "Register")
            return viewController
            
        }
    }
}
