//
//  SignInResponse.swift
//  SocietyFund
//
//  Created by sanish on 9/2/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

struct SignInResponse: Decodable {
    var token: String
    var firstName: String
    var lastName: String
    var email: String
    var profile: String
}
