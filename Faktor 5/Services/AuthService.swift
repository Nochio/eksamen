//
//  AuthService.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 29/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
  func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
          guard let user = user else {
                userCreationComplete(false, error)
                return
            }
            
          let userData = ["provider": user.user.providerID, "email": user.user.email]
          DataService.instance.createDBUser(uid: user.user.uid, userData: userData as Dictionary<String, Any>)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                loginComplete(false, error)
                return
            }
            loginComplete(true, nil)
        }
    }
}

