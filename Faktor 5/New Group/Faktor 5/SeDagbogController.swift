//
//  SeDagbogController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 03/09/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class SeDagbogController: UIViewController {

  @IBOutlet weak var textLabel: UITextView!
  @IBOutlet weak var overskriftLabel: UITextField!
  
  var texts: Dagbog?
  var dagbogArray = [Dagbog]()
  
  func initData(forDagbogText dagbogText: Dagbog) {
    self.texts = dagbogText
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func DismissKeyboard() {
      view.endEditing(true)
    }
  override func viewWillAppear(_ animated: Bool) {
    DataService.instance.getAllDagbog { (returnedDagbog) in
      self.dagbogArray = returnedDagbog
      self.overskriftLabel.text = self.texts?.overskrift
      self.textLabel.text = self.texts?.text
    }
  }

  @IBAction func tilbageBtn(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
