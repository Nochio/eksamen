//
//  BrugerGruppeController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 19/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class BrugerGruppeController: UIViewController {

  @IBOutlet weak var brugerOversigtLabel: UILabel!
  @IBOutlet weak var gruppeNavnLabel: UILabel!
  @IBOutlet weak var sendBeskedTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var sendBeskedBtn: UIButton!
  
  var group: Grupper?
  var gruppeBeskeder = [Message]()
  
  func initData(forgroup group: Grupper) {
    self.group = group
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self

  let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
    view.addGestureRecognizer(tap)

  }

  @objc func DismissKeyboard() {
    view.endEditing(true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    gruppeNavnLabel.text = group?.holdNavn
    DataService.instance.getEmailsFor(gruppe: group!) { (returnedEmails) in
      self.brugerOversigtLabel.text = returnedEmails.joined(separator: ", ")
    }
    
    DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
      DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
        self.gruppeBeskeder = returnedGroupMessages
        self.tableView.reloadData()
        
        if self.gruppeBeskeder.count > 0 {
          self.tableView.scrollToRow(at: IndexPath(row: self.gruppeBeskeder.count - 1, section: 0), at: .none, animated: true)
        }
      })
    }
  }
  
  @IBAction func tilbageBtn(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func sendBeskedBtn(_ sender: UIButton) {
    if sendBeskedTextField.text != "" {
      sendBeskedTextField.isEnabled = false
      sendBeskedBtn.isEnabled = false
      DataService.instance.uploadPost(withMessage: sendBeskedTextField.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key, sendComplete: { (complete) in
        if complete {
          self.sendBeskedTextField.text = ""
          self.sendBeskedTextField.isEnabled = true
          self.sendBeskedBtn.isEnabled = true
        }
      })
    }
    
  }
  
}

extension BrugerGruppeController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return gruppeBeskeder.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "brugerGruppeBeskeder", for: indexPath) as? BrugerGruppeCell else { return UITableViewCell() }
    
    let message = gruppeBeskeder[indexPath.row]
    
    DataService.instance.getUsername(forUID: message.senderId) { (email) in
      cell.configureCell(email: email, content: message.content)
    }
    
    return cell
  }
  
}
