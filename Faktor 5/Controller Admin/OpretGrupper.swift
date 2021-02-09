//
//  SeHoldViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 16/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class OpretGrupper: UIViewController{

  @IBOutlet weak var holdNavnTextField: UITextField!
  @IBOutlet weak var ejerNavnTextField: UITextField!
  @IBOutlet weak var findBrugerSearchField: UITextField!
  @IBOutlet weak var seDeltagereTableView: UITableView!
  @IBOutlet weak var groupMemberLbl: UILabel!
  
    var emailArray = [String]()
    var chosenUserArray = [String]()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          seDeltagereTableView.delegate = self
          seDeltagereTableView.dataSource = self
          findBrugerSearchField.delegate = self
          findBrugerSearchField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
      }

      @objc func textFieldDidChange() {
          if findBrugerSearchField.text == "" {
              emailArray = []
              seDeltagereTableView.reloadData()
          } else {
              DataService.instance.getEmail(forSearchQuery: findBrugerSearchField.text!, handler: { (returnedEmailArray) in
                  self.emailArray = returnedEmailArray
                  self.seDeltagereTableView.reloadData()
              })
          }
      }
  @IBAction func annullerBtn(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
      @IBAction func doneBtnWasPressed(_ sender: Any) {
          if holdNavnTextField.text != "" && ejerNavnTextField.text != "" {
              DataService.instance.getIds(forUsernames: chosenUserArray, handler: { (idsArray) in
                  var userIds = idsArray
                  userIds.append((Auth.auth().currentUser?.uid)!)
                  
                DataService.instance.createGroup(holdnavn: self.holdNavnTextField.text!, ejernavn: self.ejerNavnTextField.text!, forUserIds: userIds, handler: { (groupCreated) in
                      if groupCreated {
                          self.dismiss(animated: true, completion: nil)
                        print("Gruppen blev oprettet")
                      } else {
                          print("Group could not be created. Please try again.")
                      }
                  })
              })
          }
      }
      
  }

  extension OpretGrupper: UITableViewDelegate, UITableViewDataSource {
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return emailArray.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: "deltager") as? DeltagerOversigtCell else { return UITableViewCell() }
          
          if chosenUserArray.contains(emailArray[indexPath.row]) {
              cell.configureCell(email: emailArray[indexPath.row], isSelected: true)
          } else {
              cell.configureCell(email: emailArray[indexPath.row], isSelected: false)
          }
          
          return cell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          guard let cell = tableView.cellForRow(at: indexPath) as? DeltagerOversigtCell else { return }
          if !chosenUserArray.contains(cell.deltagerLabel.text!) {
              chosenUserArray.append(cell.deltagerLabel.text!)
              groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
          } else {
             chosenUserArray = chosenUserArray.filter({ $0 != cell.deltagerLabel.text! })
              if chosenUserArray.count >= 1 {
                  groupMemberLbl.text = chosenUserArray.joined(separator: ", ")
              } else {
                  groupMemberLbl.text = "add people to your group"
              }
        }
      }
  }

  extension OpretGrupper: UITextFieldDelegate {
      
  }
