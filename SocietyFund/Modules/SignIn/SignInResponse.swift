//
//  SignInResponse.swift
//  SocietyFund
//
//  Created by sanish on 9/2/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

struct SignInResponse: Codable {
    var success: Bool?
    var message: String?
    var data: LoginData?
}

struct LoginData: Codable {
    var firstname: String?
    var lastname: String?
    var email: String?
    var phone: String?
    var imgUrl: String?
}
