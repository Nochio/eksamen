//
//  UserCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 22/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

  @IBOutlet weak var checkImage: UIImageView!
  @IBOutlet weak var userLabel: UILabel!
  
  var showing = false
  
  func configureCell(email: String, isSelected: Bool) {
    self.userLabel.text = email
    if isSelected {
      self.checkImage.isHidden = false
    } else {
      self.checkImage.isHidden = true
    }
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected {
      if showing == false {
        checkImage.isHidden = false
        showing = true
      } else {
        checkImage.isHidden = true
        showing = false
      }
    }
  }

}
