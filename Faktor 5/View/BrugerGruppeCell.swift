//
//  BrugerGruppeCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 19/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class BrugerGruppeCell: UITableViewCell {

  @IBOutlet weak var brugerTextLabel: UILabel!
  @IBOutlet weak var beskedTextLabel: UILabel!
  
  func configureCell(email: String, content: String) {
    self.brugerTextLabel.text = email
    self.beskedTextLabel.text = content
  }

}
