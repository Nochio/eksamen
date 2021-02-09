//
//  TextBeskedCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 21/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class TextBeskedCell: UITableViewCell {

  @IBOutlet weak var brugerLabel: UILabel!
  @IBOutlet weak var beskedLabel: UILabel!
  
  func configureCell(email: String, content: String) {
    self.brugerLabel.text = email
    self.beskedLabel.text = content
  }

}
