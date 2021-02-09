//
//  DagbogOversigtCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 03/09/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class DagbogOversigtCell: UITableViewCell {

  @IBOutlet weak var dagbogLabel: UILabel!
  
  func configureCell(overskrift: String) {
    self.dagbogLabel.text = overskrift
  }
  

}
