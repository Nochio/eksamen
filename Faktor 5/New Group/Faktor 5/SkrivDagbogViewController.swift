//
//  SkrivDagbogViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 15/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class SkrivDagbogViewController: UIViewController {

  @IBOutlet weak var overskriftTextField: UITextField!
  @IBOutlet weak var dagbogTextField: UITextView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func DismissKeyboard() {
      view.endEditing(true)
    }
  
  
    

  @IBAction func gemBtn(_ sender: UIButton) {
    
    DataService.instance.uploadDagbog(withHeadline: overskriftTextField.text!, withText: dagbogTextField.text!, withDagbogKey: nil, sendComplete: { (isComplete) in
        self.dismiss(animated: true, completion: nil)
    })
    
  }

  @IBAction func tilbageBtn(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
