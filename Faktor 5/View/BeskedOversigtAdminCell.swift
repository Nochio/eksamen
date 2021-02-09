//
//  BeskedOversigtAdminCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 30/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class BeskedOversigtAdminCell: UITableViewCell {

    @IBOutlet weak var medlemsLabel: UILabel!
      
      func configureCell(medlemmer: [String]) {
        self.medlemsLabel.text = "\(medlemmer)"
      }
      
    }
