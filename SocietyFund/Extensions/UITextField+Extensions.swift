//
//  UITextField+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit
import Material

extension UITextField {
    
    func customTextField() {
        self.borderStyle = .roundedRect
        self.setBorderColor(color: ColorConfig.BorderColor.cgColor, width: 2)
        self.setCorner(no: 10)
        self.textColor = ColorConfig.BorderColor
        self.tintColor = ColorConfig.BorderColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "JUST A REPLACE",
                                                        attributes: [NSAttributedString.Key.foregroundColor: ColorConfig.BorderColor])
    }
    
    func setBorderNone() {
        self.borderStyle = .none
    }
    
    func setBackground(color: UIColor) {
        self.backgroundColor = color
    }
    
    func showHideError() {
        if self.text?.isEmpty ?? true {
            (self as? ErrorTextField)?.isErrorRevealed = true
        } else {
            (self as? ErrorTextField)?.isErrorRevealed = false
        }
    }
    
}

extension TextField {
    
    func styleTextLight() {
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.white
        self.dividerNormalColor = UIColor.white
        self.dividerActiveColor = UIColor.white
        self.dividerNormalHeight = 1.0
        self.dividerActiveHeight = 2.5
        self.placeholderNormalColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        self.placeholderActiveColor = UIColor.white
    }
    
    func styleTextRegular() {
        self.backgroundColor = UIColor.clear
        self.textColor = UIColor.black
        self.dividerNormalColor = UIColor.lightGray
        self.dividerActiveColor = ColorConfig.BorderColor
        self.dividerNormalHeight = 1.0
        self.dividerActiveHeight = 2.5
        self.placeholderNormalColor = UIColor.darkGray
        self.placeholderActiveColor = ColorConfig.BorderColor
    }
    
  
}
