//
//  RoundedUIView.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 1/5/20.
//  Copyright © 2020 Dream Catcher. All rights reserved.
//

import UIKit

@IBDesignable class RoundedUIView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

}
