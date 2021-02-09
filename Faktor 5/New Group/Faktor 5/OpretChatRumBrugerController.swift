//
//  OpretChatRumBrugerController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 22/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class OpretChatRumBrugerController: UIViewController {

  @IBOutlet weak var brugerTextField: UITextField!
  @IBOutlet weak var seBrugereLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  var emailArray = [String]()
  var chosenUserArray = [String]()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    brugerTextField.delegate = self
    brugerTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        
    }
  @objc func textFieldDidChange() {
      if brugerTextField.text == "" {
          emailArray = []
          tableView.reloadData()
      } else {
          DataService.instance.getEmail(forSearchQuery: brugerTextField.text!, handler: { (returnedEmailArray) in
              self.emailArray = returnedEmailArray
              self.tableView.reloadData()
          })
      }
  }

  @IBAction func gemBtn(_ sender: UIButton) {
    DataService.instance.getIds(forUsernames: chosenUserArray, handler: { (idsArray) in
      var userIds = idsArray
      userIds.append((Auth.auth().currentUser?.uid)!)
      
      DataService.instance.createChatGroup(forUserIds: userIds, handler: { (groupCreated) in
        if groupCreated {
          self.dismiss(animated: true, completion: nil)
        } else {
          print("Fejl")
        }
      })
    })
  }
}

extension OpretChatRumBrugerController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return emailArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
    
    if chosenUserArray.contains(emailArray[indexPath.row]) {
      cell.configureCell(email: emailArray[indexPath.row], isSelected: true)
    } else {
      cell.configureCell(email: emailArray[indexPath.row], isSelected: false)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
    if !chosenUserArray.contains(cell.userLabel.text!) {
      chosenUserArray.append(cell.userLabel.text!)
      seBrugereLabel.text = chosenUserArray.joined(separator: ", ")
    } else {
      chosenUserArray = chosenUserArray.filter({ $0 != cell.userLabel.text! })
          if chosenUserArray.count >= 1 {
              seBrugereLabel.text = chosenUserArray.joined(separator: ", ")
          } else {
              seBrugereLabel.text = "add people to your group"
          }
    }
  }
  
}

extension OpretChatRumBrugerController: UITextFieldDelegate {
  
}
