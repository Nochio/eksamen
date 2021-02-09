//
//  OpretBrugerViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 24/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class OpretBrugerViewController: UIViewController {

  @IBOutlet weak var brugernavnTextField: UITextField!
  @IBOutlet weak var kodeordTextField: UITextField!
  @IBOutlet weak var navneTextField: UITextField!
  
  var email: String!
  var password: String!
  
  override func viewDidLoad() {
        super.viewDidLoad()

  let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
      view.addGestureRecognizer(tap)
      
    }

  @objc func DismissKeyboard() {
    
    view.endEditing(true)
  }
  
  @IBAction func gemBrugerBtn(_ sender: UIButton) {
    AuthService.instance.registerUser(withEmail: self.brugernavnTextField.text!, andPassword: self.kodeordTextField.text!, userCreationComplete: { (success, registrationError) in
       if success {
           AuthService.instance.loginUser(withEmail: self.brugernavnTextField.text!, andPassword: self.kodeordTextField.text!, loginComplete: { (success, nil) in
               self.dismiss(animated: true, completion: nil)
            
            DataService.instance.uploadNavn(withNavn: self.navneTextField.text!, withNavneKey: nil, sendComplete: { (isComplete) in
              if isComplete {
                
              }
            })
            
               print("Successfully registered user")
           })
       } else {
           print(String(describing: registrationError?.localizedDescription))
       }
   })
    
    
    
  }
}
