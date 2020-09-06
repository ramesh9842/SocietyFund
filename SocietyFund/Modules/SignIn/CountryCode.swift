//
//  CountryCode.swift
//  SocietyFund
//
//  Created by sanish on 9/6/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation


struct CountryCode: Codable {
    var name: String?
    var dialCode: String?
    var code: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case dialCode = "dial_code"
        case code
    }
    
}
