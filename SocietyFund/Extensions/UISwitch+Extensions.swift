//
//  UISwitch+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation
import UIKit

extension UISwitch {
    
    func setSwitchStyle() {
        self.isOn = false
        self.onTintColor = ColorConfig.ButtonPrimary
        self.transform = CGAffineTransform(scaleX: 0.65, y: 0.65)
    }
}
