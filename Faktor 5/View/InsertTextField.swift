//
//  InsertTextField.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 28/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {

    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override func awakeFromNib() {
      
        super.awakeFromNib()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
}

