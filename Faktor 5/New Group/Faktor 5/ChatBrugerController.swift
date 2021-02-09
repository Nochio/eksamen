//
//  ChatBrugerController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 23/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class ChatBrugerController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var deltagerLabel: UILabel!
  @IBOutlet weak var skrivBeskedTextField: UITextField!
  @IBOutlet weak var sendBeskedBtn: UIButton!
  
  var chatBeskeder = [Message]()
  var group: ChatGruppe?
  
  func initData(forGroup group: ChatGruppe) {
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
    DataService.instance.getChatEmailsFor(gruppe: group!) { (returnedEmails) in
      self.deltagerLabel.text = returnedEmails.joined(separator: ", ")
    }
    
    DataService.instance.REF_CHAT.observe(.value) { (snapshot) in
      DataService.instance.getAllChatMessages(desiredChatGroup: self.group!, handler: { (returnedChatMessages) in
        self.chatBeskeder = returnedChatMessages
        self.tableView.reloadData()
        
        if self.chatBeskeder.count > 0 {
          self.tableView.scrollToRow(at: IndexPath(row: self.chatBeskeder.count - 1, section: 0), at: .none, animated: true)
        }
      })
    }
  }
  
  @IBAction func sendBeskedBtn(_ sender: UIButton) {
    if skrivBeskedTextField.text != "" {
      skrivBeskedTextField.isEnabled = false
      sendBeskedBtn.isEnabled = false
      DataService.instance.uploadChat(withChat: skrivBeskedTextField.text!, forUID: Auth.auth().currentUser!.uid, withChatKey: group?.key, sendComplete: { (complete) in
        if complete {
          self.skrivBeskedTextField.text = ""
          self.skrivBeskedTextField.isEnabled = true
          self.sendBeskedBtn.isEnabled = true
        }
      })
    }
  }
  
  @IBAction func tilbageBtn(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}

extension ChatBrugerController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatBeskeder.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "textBeskedCell", for: indexPath) as? TextBeskedCell else { return UITableViewCell()}
    let chat = chatBeskeder[indexPath.row]
    
    DataService.instance.getUsername(forUID: chat.senderId) { (email) in
      cell.configureCell(email: email, content: chat.content)
    }
    return cell
  }
  
  
}
