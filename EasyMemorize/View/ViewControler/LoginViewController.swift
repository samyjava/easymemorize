//
//  LoginViewController.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 12/24/19.
//  Copyright © 2019 Dream Catcher. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController, BindableType {
    
    @IBOutlet weak var passwordTextField: UITextField!
    let bag = DisposeBag()
    
    var viewModel: LoginViewModel!
    func bindViewModel() {
        self.viewModel.loginWay().subscribe(onSuccess: { loginWay in
            switch loginWay {
            case .faceID, .fingerID:
                self.passwordTextField.isHidden = true
                self.passwordTextField.resignFirstResponder()
                self.viewModel.detectBiometric().execute()
            case .none:
                self.passwordTextField.isHidden = true
                self.passwordTextField.resignFirstResponder()
            default:
                return
            }
        }).disposed(by: self.bag)
        
        self.passwordTextField.rx.controlEvent(.primaryActionTriggered).subscribe(onNext: { _ in
            self.viewModel.authenticate().execute(self.passwordTextField.text!).subscribe(onError: { [weak self] _ in
                self?.showAlert(message: "Password is incorrect")
            }).disposed(by: self.bag)
            }).disposed(by: self.bag)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTextField.becomeFirstResponder()
    }
    
    
    
}
