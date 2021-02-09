//
//  SeGruppeViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 07/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

//
//  SeGruppeViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 29/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class SeGruppeViewController: UIViewController {
  
  @IBOutlet weak var seGruppeTableView: UITableView!
  @IBOutlet weak var membersLbl: UILabel!
  @IBOutlet weak var beskedTextfield: UITextField!
  @IBOutlet weak var sendBeskedBtn: UIButton!
  @IBOutlet weak var gruppeHoldNavnLbl: UILabel!
  
  var group: Grupper?
  var gruppeBeskeder = [Message]()
  
  func initData(forGroup group: Grupper) {
      self.group = group
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()
    seGruppeTableView.delegate = self
    seGruppeTableView.dataSource = self

        
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
      view.addGestureRecognizer(tap)

    }

    @objc func DismissKeyboard() {
      view.endEditing(true)
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    gruppeHoldNavnLbl.text = group?.holdNavn
    DataService.instance.getEmailsFor(gruppe: group!) { (returnedEmails) in
        self.membersLbl.text = returnedEmails.joined(separator: ", ")
    }
    
    DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
        DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
            self.gruppeBeskeder = returnedGroupMessages
            self.seGruppeTableView.reloadData()
            
            if self.gruppeBeskeder.count > 0 {
                self.seGruppeTableView.scrollToRow(at: IndexPath(row: self.gruppeBeskeder.count - 1, section: 0), at: .none, animated: true)
            }
        })
    }
  }
  @IBAction func tilbageBtn(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func sendBtn(_ sender: UIButton) {
    if beskedTextfield.text != "" {
        beskedTextfield.isEnabled = false
      sendBeskedBtn.isEnabled = false
        DataService.instance.uploadPost(withMessage: beskedTextfield.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key, sendComplete: { (complete) in
            if complete {
                self.beskedTextfield.text = ""
                self.beskedTextfield.isEnabled = true
                self.sendBeskedBtn.isEnabled = true
            }
        })
    }
  }
}

extension SeGruppeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gruppeBeskeder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "seGruppeCell", for: indexPath) as? SeGruppeCell else { return UITableViewCell() }
      let message = gruppeBeskeder[indexPath.row]
      
      DataService.instance.getUsername(forUID: message.senderId) { (email) in
        cell.configureCell(email: email, content: message.content)
        
      }
      return cell
    }
}
