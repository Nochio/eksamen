//
//  DeltagerOversigtCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 24/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class DeltagerOversigtCell: UITableViewCell {

  @IBOutlet weak var deltagerLabel: UILabel!
  @IBOutlet weak var checkImageView: UIImageView!
  
   var showing = false
      
      func configureCell(email: String, isSelected: Bool) {
          self.deltagerLabel.text = email
          if isSelected {
              self.checkImageView.isHidden = false
          } else {
              self.checkImageView.isHidden = true
          }
      }
      
      override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          if selected {
              if showing == false {
                  checkImageView.isHidden = false
                  showing = true
              } else {
                  checkImageView.isHidden = true
                  showing = false
              }
          }
      }
  }
