//
//  Dagbog.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 03/09/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import Foundation

class Dagbog {
  private var _overskrift: String
  private var _text: String
  
  var text: String {
    return _text
  }
  
  var overskrift: String {
    return _overskrift
  }
  
  init(overskrift: String, text: String) {
    self._overskrift = overskrift
    self._text = text
  }
}
