//
//  ProfilAdminViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 16/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class ProfilAdminViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

  @IBAction func logudBtn(_ sender: UIButton) {
    do {
        try Auth.auth().signOut()
      self.performSegue(withIdentifier: "toLoginVC", sender: nil)
        
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
    
  }
}
