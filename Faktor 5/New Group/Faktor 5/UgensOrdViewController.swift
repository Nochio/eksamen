//
//  UgensOrdViewController.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 15/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit
import Firebase

class UgensOrdViewController: UIViewController {

  @IBOutlet weak var ugensOrdTableView: UITableView!
  
  var messageArray = [Message]()
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    ugensOrdTableView.delegate = self
    ugensOrdTableView.dataSource = self
    
      
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
      self.messageArray = returnedMessagesArray.reversed()
      self.ugensOrdTableView.reloadData()
    }
  }
  
}

extension UgensOrdViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messageArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ugensord") as? UgensOrdCell else { return UITableViewCell() }
    let message = messageArray[indexPath.row]
    
    cell.configureCell(content: message.content)
    return cell
  }

}
