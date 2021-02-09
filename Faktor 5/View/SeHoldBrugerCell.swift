//
//  SeHoldBrugerCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 07/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class SeHoldBrugerCell: UITableViewCell {

  @IBOutlet weak var holdNavnLabel: UILabel!
  @IBOutlet weak var ejerNavnLabel: UILabel!
  @IBOutlet weak var antalMedlemmerLabel: UILabel!
  
  func configureCell(holdNavn: String, ejerNavn: String, antalMedlemmer: Int) {
      self.holdNavnLabel.text = holdNavn
      self.ejerNavnLabel.text = ejerNavn
      self.antalMedlemmerLabel.text = "\(antalMedlemmer) medlemmer."
  }

}
