//
//  SignUpViewModel.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

protocol SignUpDelegate: class {
    func onSuccess(_ response: SignUpResponse)
    func onFailure(msg: String, title: String)
}

class SignUpViewModel {
    
    var delegate: SignUpDelegate?
    func signUp(firstName: String, lastName: String, mobile: String, email: String, password: String) {
        let params = ["firstName": firstName, "lastName": lastName, "mobile": mobile, "email": email, "password": password]
        APIService.shared.request("https://run.mocky.io/v3/c41e78c0-b5e8-498c-b09b-9a60cddcb221", method: .POST, params: params) { [weak self](result: (Result<SignUpResponse, APIError>)) in
            switch result {
            case .success(let signUpResponse):
                Log.debug(msg: signUpResponse)
                self?.delegate?.onSuccess(signUpResponse)
            case .failure(let error):
                self?.delegate?.onFailure(msg: error.rawValue, title: "")
            }
        }
    }
    
}
