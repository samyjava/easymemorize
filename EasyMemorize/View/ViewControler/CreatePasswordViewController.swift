//
//  CreatePasswordViewController.swift
//  EasyMemorize
//
//  Created by Yasaman Farahani Saba on 1/6/20.
//  Copyright © 2020 Dream Catcher. All rights reserved.
//

import UIKit

class CreatePasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard self.passwordTextField.text != nil ,!self.passwordTextField.text!.isEmpty else {
            showAlert(message: "Please enter your password!")
            return
        }
        guard self.passwordTextField.text == self.confirmTextField.text else {
            showAlert(message: "Password dosen't match!")
            return
        }
        if let parentViewController = self.presentingViewController as? RegisterViewController {
            parentViewController.setPassword(pass: self.passwordTextField.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
