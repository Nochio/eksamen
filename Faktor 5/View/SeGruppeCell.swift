//
//  SeGruppeCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 07/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class SeGruppeCell: UITableViewCell {

  @IBOutlet weak var seBrugerLabel: UILabel!
  @IBOutlet weak var seBeskedLabel: UILabel!
  
  func configureCell(email: String, content: String) {
    self.seBrugerLabel.text = email
    self.seBeskedLabel.text = content
  }

}

