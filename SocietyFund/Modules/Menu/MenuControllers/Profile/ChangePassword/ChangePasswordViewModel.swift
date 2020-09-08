//
//  ChangePasswordViewModel.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation

class ChangePasswordViewModel {
    
    var delegate: ChangePasswordDelegate?
    func changePassword(newPassword: String) {
        let params = ["newpassword": newPassword]
        APIService.shared.request("https://run.mocky.io/v3/c41e78c0-b5e8-498c-b09b-9a60cddcb221", method: .POST, params: params) { [weak self](result: (Result<ChangePasswordResponse, APIError>)) in
            switch result {
            case .success(let response):
                Log.debug(msg: response)
                self?.delegate?.onSuccess(response)
            case .failure(let error):
                self?.delegate?.onFailure(msg: error.rawValue, title: "")
            }
        }
    }

}
