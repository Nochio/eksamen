//
//  Grupper.swift
//  Faktor 5
//
//  Created by Thomas Hinrichs on 07/08/2020.
//  Copyright © 2020 Thomas Hinrichs. All rights reserved.
//

import Foundation

class Grupper {
    private var _holdNavn: String
    private var _ejerNavn: String
    private var _key: String
    private var _antalMedlemmer: Int
    private var _medlemmer: [String]
    
    var holdNavn: String {
        return _holdNavn
    }
    
    var ejerNavn: String {
        return _ejerNavn
    }
    
    var key: String {
        return _key
    }
    
    var antalMedlemmer: Int {
        return _antalMedlemmer
    }
    
    var medlemmer: [String] {
        return _medlemmer
    }
    
    init(holdNavn: String, ejerNavn: String, key: String, medlemmer: [String], antalMedlemmer: Int) {
        self._holdNavn = holdNavn
        self._ejerNavn = ejerNavn
        self._key = key
        self._medlemmer = medlemmer
        self._antalMedlemmer = antalMedlemmer
    }
}
