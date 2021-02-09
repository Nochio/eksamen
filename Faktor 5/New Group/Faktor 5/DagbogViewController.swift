//
//  DagbogViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 15/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class DagbogViewController: UIViewController {
  
  @IBOutlet weak var dagbogTableView: UITableView!
  
  var dagbogArray = [Dagbog]()
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    dagbogTableView.delegate = self
    dagbogTableView.dataSource = self
    print(dagbogArray)


  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    DataService.instance.REF_TEXT.observe(.value) { (snapshot) in
      DataService.instance.getAllDagbog { (returnedTextArray) in
        self.dagbogArray = returnedTextArray
        self.dagbogTableView.reloadData()

      }
    }
  }
  
  @IBAction func tilSkrivDagbogBtn(_ sender: UIButton) {
    performSegue(withIdentifier: "skrivdagbog", sender: nil)
  }
  
}

extension DagbogViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dagbogArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = dagbogTableView.dequeueReusableCell(withIdentifier: "dagbog", for: indexPath) as? DagbogOversigtCell else { return UITableViewCell() }
    let dagbog = dagbogArray[indexPath.row]
    cell.configureCell(overskrift: dagbog.overskrift)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let seDagbog = storyboard!.instantiateViewController(identifier: "sedagbog") as? SeDagbogController else { return }
    
    seDagbog.initData(forDagbogText: dagbogArray[indexPath.row])
    seDagbog.modalPresentationStyle = .fullScreen
    presentDetail(seDagbog)
    
    
  }
  
}
