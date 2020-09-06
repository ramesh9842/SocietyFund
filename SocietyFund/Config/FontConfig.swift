//
//  FontConfig.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

struct FontConfig {
    
    var boldFont: UIFont!
    var regularFont: UIFont!
    var semiboldFont: UIFont!
    var italic: UIFont!
    
    public init(fontSize: CGFloat? = 14) {
        self.boldFont = UIFont(name: "Segoe UI Bold", size: fontSize!) ?? UIFont.boldSystemFont(ofSize: fontSize!)
        self.regularFont = UIFont(name: "Segoe UI", size: fontSize!) ?? UIFont.systemFont(ofSize: fontSize!)
        self.semiboldFont = UIFont(name: "seguisb", size: fontSize!) ?? UIFont.systemFont(ofSize: fontSize!)
         self.italic = UIFont(name: "Segoe UI Italic", size: fontSize!) ?? UIFont.systemFont(ofSize: fontSize!)
    }
}
