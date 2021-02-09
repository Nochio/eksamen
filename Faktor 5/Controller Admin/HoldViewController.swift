//
//  HoldViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 16/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
//import Firebase

class HoldViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var holdOversigtTableView: UITableView!
  
  var groupsArray = [Grupper]()

  override func viewDidLoad() {
    super.viewDidLoad()
    holdOversigtTableView.delegate = self
    holdOversigtTableView.dataSource = self
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
    view.addGestureRecognizer(tap)

  }
  
  override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
          DataService.instance.getAllGroups { (returnedGroupsArray) in
              self.groupsArray = returnedGroupsArray
              self.holdOversigtTableView.reloadData()
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
      guard let cell = holdOversigtTableView.dequeueReusableCell(withIdentifier: "Hold", for: indexPath) as? HoldOversigtCell else { return UITableViewCell() }
      let gruppe = groupsArray[indexPath.row]
    cell.configureCell(holdNavn: gruppe.holdNavn, ejerNavn: gruppe.ejerNavn, antalMedlemmer: gruppe.antalMedlemmer)
      return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let seGruppe = storyboard?.instantiateViewController(withIdentifier: "seGruppeViewController") as? SeGruppeViewController else { return }
    
    seGruppe.initData(forGroup: groupsArray[indexPath.row])
    seGruppe.modalPresentationStyle = .fullScreen
    presentDetail(seGruppe)
      
  }
}
