//
//  MessageCell.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 25/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

  
  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var rightImageView: UIImageView!
  @IBOutlet weak var leftImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
