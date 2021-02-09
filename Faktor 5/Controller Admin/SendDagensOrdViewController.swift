//
//  SendDagensOrdViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 16/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class SendUgensOrdViewController: UIViewController {
  
  @IBOutlet weak var sendBeskedTextField: UITextView!
  @IBOutlet weak var sendBtn: UIButton!
  
  var group: Grupper?
  var groupMessages = [Message]()
  
  func initData(forGroup group: Grupper) {
      self.group = group
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
    sendBeskedTextField.delegate = self

  let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
      view.addGestureRecognizer(tap)

  }

  @objc func DismissKeyboard() {
    
    view.endEditing(true)
  }
  
  
  @IBAction func sendBeskedBtn(_ sender: UIButton) {
    if sendBeskedTextField.text != nil {
      sendBtn.isEnabled = false
      DataService.instance.uploadPost(withMessage: sendBeskedTextField.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
        if isComplete {
          self.sendBtn.isEnabled = true
          self.dismiss(animated: true, completion: nil)
        } else {
          self.sendBtn.isEnabled = true
        }
      })
    }
  }
  
}

extension SendUgensOrdViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    sendBeskedTextField.text = ""
  }
}
