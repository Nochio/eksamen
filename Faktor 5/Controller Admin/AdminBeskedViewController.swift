//
//  AdminBeskedViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 19/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class AdminBeskedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  
  var groupsArray = [ChatGruppe]()
  
   override func viewDidLoad() {
          super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self

      
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
      view.addGestureRecognizer(tap)
      
      }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      DataService.instance.REF_CHAT.observe(.value) { (snapshot) in
        DataService.instance.getAllChatGroups { (returnedChatGroupsArray) in
          self.groupsArray = returnedChatGroupsArray
          self.tableView.reloadData()
        }
      }
    }
    
    @objc func DismissKeyboard() {
      view.endEditing(true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "adminBeskedOversigtCell", for: indexPath) as? BeskedOversigtAdminCell else { return UITableViewCell()}
      
      let gruppe = groupsArray[indexPath.row]
      cell.configureCell(medlemmer: gruppe.medlemmer)
      
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let seChatGruppe = storyboard?.instantiateViewController(identifier: "seChatRumBruger") as? ChatBrugerController else { return }
      
      seChatGruppe.initData(forGroup: groupsArray[indexPath.row])
      seChatGruppe.modalPresentationStyle = .fullScreen
      presentDetail(seChatGruppe)
    }
    
  }
