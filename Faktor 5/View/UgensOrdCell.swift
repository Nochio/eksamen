//
//  UgensOrdCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 18/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class UgensOrdCell: UITableViewCell {

  @IBOutlet weak var ugensOrdLabel: UILabel!
  

  func configureCell(content: String) {
    self.ugensOrdLabel.text = content
  }

}
