//
//  LoginViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 15/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
    view.addGestureRecognizer(tap)

  }
  
  @objc func DismissKeyboard() {
    
    view.endEditing(true)
  }
  
  @IBAction func loginBtnPressed(_ sender: UIButton) {
    if let email = emailTextField.text, let password = passwordTextField.text {
      if email == "rh@faktor5.dk" || email == "lasse@faktor5.dk"{
        AuthService.instance.loginUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!, loginComplete: { (success, loginError) in
            if success {
                self.dismiss(animated: true, completion: nil)
              self.performSegue(withIdentifier: "toAdminVC", sender: self)
            } else {
                print(String(describing: loginError?.localizedDescription))
            }
        })
      } else {
          Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
              print(e)
            } else {
              self.performSegue(withIdentifier: "toUserVC", sender: self)
            }
          }
      }
    }
  }
}
