//
//  ChangePasswordValidator.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

protocol ChangePasswordDelegate: class {
    func onSuccess(_ response: ChangePasswordResponse)
    func onFailure(msg: String, title: String)
}

class ChangePasswordValidator {
    
    var isGoodToGo = false
    var passwordErr = false
    var confirmErr = false
    var vmChange: ChangePasswordViewModel!
    var delegate: ChangePasswordDelegate?
    
    init(vm: ChangePasswordViewModel) {
        self.vmChange = vm
    }
    func validate(tfOldPassword: UITextField, tfNewPassword: UITextField, tfConfirmPassword: UITextField) {
        guard let oldPassword = tfOldPassword.text?.trimmed, let newPassword = tfNewPassword.text?.trimmed, let confirmPassword = tfConfirmPassword.text?.trimmed else { return }
        
        if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
            delegate?.onFailure(msg: "Fields can't be empty.", title: "Empty Field!")
            isGoodToGo = false
        }else {
            if(!newPassword.isValidRegEx(.password)) {
                delegate?.onFailure(msg: "Password Length 6-15 characters.", title: "Invalid Password Format!")
                confirmErr = false
            }else {
                passwordErr = true
            }
            if(newPassword != confirmPassword) {
                delegate?.onFailure(msg: "Enter same password", title: "Password Mismatch!")
                confirmErr = false
            }else {
                confirmErr = true
            }
        }
        isGoodToGo = passwordErr && confirmErr
        if isGoodToGo {
            vmChange.changePassword(newPassword: newPassword)
        }
    }
    
}
