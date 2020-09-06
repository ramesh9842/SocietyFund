//
//  ErrorTextField+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//
import Foundation
import Material

extension ErrorTextField {
    
    func required(errorLbl: String? = "Required!") {
        self.errorLabel.text = errorLbl
        self.errorLabel.textAlignment = .right
        self.errorLabel.textColor = UIColor.red
        self.isErrorRevealed = true
    }
    
    func notRequired() {
        self.errorLabel.text = ""
    }
}
