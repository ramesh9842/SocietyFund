//
//  InputValidator.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class InputValidator {
    var delegate: SignInDelegate?
    var usernameErr = false
    var passwordErr = false
    
    var signInVM: SignInViewModel
    
    init(vm: SignInViewModel) {
        signInVM = vm
    }
    
    func validate(tfMobile: UITextField, tfPassword: UITextField) {
        guard let username = tfMobile.text?.trimmed, let password = tfPassword.text?.trimmed else { return }
        if (username.isEmpty) {
            delegate?.onFailure(msg: "Enter Username", title: "Empty Field!")
        }else {
            if(username.isValidRegEx(.email)) || (username.isValidRegEx(.phoneNo)) {
                usernameErr = true
            }else {
                delegate?.onFailure(msg: "e.g. mike@fine.co/ 9810219190", title: "Invalid Username!")
            }
        }
        
        if (password.isEmpty) {
            delegate?.onFailure(msg: "Enter Password.", title: "Empty Field!")
        }else {
            if !password.isValidRegEx(.password) {
                delegate?.onFailure(msg: "Password Length 6-15 characters.", title: "Invalid Password Format!")
            }else {
                passwordErr = true
            }
        }
        
        if(usernameErr == true && passwordErr == true){
            signInVM.signIn(username: username, password: password)
        }
    }
    
}
