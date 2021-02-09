//
//  UIViewExt.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 30/07/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import UIKit

extension UIView {
    func bindToKeyboard() {
      
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        
      let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
      let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
      let beginningFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
      let endFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = endFrame.origin.y - beginningFrame.origin.y
        
      UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
        }, completion: nil)
    }
}

