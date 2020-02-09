//
//  ViewController.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 11/25/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import AVFoundation

class RegisterViewController: UIViewController, BindableType {
    
    let bag = DisposeBag()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var biometricStack: UIStackView!
    @IBOutlet weak var passwordStack: UIStackView!
    @IBOutlet weak var noneStack: UIStackView!
    
    var viewModel: RegisterViewModel!
    func bindViewModel() {
        
        self.viewModel.availableLoginWays().subscribe(onNext: { loginWays in
            loginWays.forEach { loginWay in
                switch loginWay {
                case .faceID:
                    self.biometricStack.isHidden = false
                    self.biometricStack.rx.tapGesture().subscribe(onNext: { _ in
                        let user = UserItem(userName: self.nameTextField.text ?? "Unknown", loginWay: .faceID)
                        self.viewModel.register().execute(user)
                    }).disposed(by: self.bag)
                case .fingerID:
                    self.biometricStack.isHidden = false
                    self.biometricStack.rx.tapGesture().subscribe(onNext: { _ in
                        let user = UserItem(userName: self.nameTextField.text ?? "Unknown", loginWay: .fingerID)
                        self.viewModel.register().execute(user)
                    }).disposed(by: self.bag)
                    
                case .none:
                    self.noneStack.isHidden = false
                    self.noneStack.rx.tapGesture().subscribe(onNext: { _ in
                        let user = UserItem(userName: self.nameTextField.text ?? "Unknown", loginWay: .none)
                        self.viewModel.register().execute(user)
                    }).disposed(by: self.bag)
                    
                case .pinLogin:
                    self.passwordStack.isHidden = false
                    self.passwordStack.rx.tapGesture().subscribe(onNext: { _ in
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let createPassword = storyboard.instantiateViewController(identifier: "CreatePassword")
                        self.present(createPassword, animated: true, completion: nil)
                    }).disposed(by: self.bag)
                }
            }
        }).disposed(by: self.bag)
        
        
        
    }
    
    public func setPassword(pass: String) {
        let user = UserItem(userName: self.nameTextField.text ?? "Unknown", loginWay: .pinLogin, prsImage: nil, password: pass)
        self.viewModel.register().execute(user)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

