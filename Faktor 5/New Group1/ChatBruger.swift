//
//  ChatBruger.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 22/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import Foundation

class ChatGruppe {
  
  private var _key: String
  private var _medlemmer: [String]
  
  var key: String {
    return _key
  }
  
  var medlemmer: [String] {
    return _medlemmer
  }
  
  init(key: String, medlemmer: [String]) {
    self._key = key
    self._medlemmer = medlemmer
  }
  
}
