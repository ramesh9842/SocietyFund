//
//  SignUpInputValidator.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class SignUpInputValidator {
    
    var isGoodToGo = false
    var mobileErr = false
    var emailErr = false
    var passwordErr = false
    var confirmErr = false
    var vmSignUp: SignUpViewModel!
    var delegate: SignUpDelegate?
    
    init(vm: SignUpViewModel) {
        self.vmSignUp = vm
    }
    
    func validate(tfFName: UITextField, tfLName: UITextField, tfGeoCode: UITextField, tfMobile: UITextField, tfEmail: UITextField, tfPassword: UITextField, tfConfirm: UITextField) {
        
        guard let fname = tfFName.text?.trimmed, let lname = tfLName.text?.trimmed, let geocode = tfGeoCode.text?.trimmed, let mobile = tfMobile.text?.trimmed, let email = tfEmail.text?.trimmed, let password = tfPassword.text?.trimmed, let confirm = tfConfirm.text?.trimmed  else { return }
        
        if (fname.isEmpty || lname.isEmpty || geocode.isEmpty || mobile.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
            delegate?.onFailure(msg:"Fields can't be empty.", title: "Empty Field!")
            isGoodToGo = false
        }else {
            if(!mobile.isValidRegEx(.phoneNo)) {
                delegate?.onFailure(msg: "e.g. 9810219190", title: "Invalid Mobile Number!")
                mobileErr = false
            }else {
                mobileErr = true
            }
            if(!email.isValidRegEx(.email)) {
                delegate?.onFailure(msg: "e.g. mike@hello.com", title: "Invalid Email!")
                emailErr = false
            }else {
                emailErr = true
            }
            if(!password.isValidRegEx(.password)) {
                delegate?.onFailure(msg: "Password Length 6-15 characters.", title: "Invalid Password Format!")
                passwordErr = false
            }else {
                passwordErr = true
            }
            if(password != confirm) {
                delegate?.onFailure(msg: "Enter same password", title: "Password Mismatch!")
                confirmErr = false
            }else{
                confirmErr = true
            }
        }
        isGoodToGo = mobileErr && emailErr && passwordErr && confirmErr
        if isGoodToGo {
            Log.debug(msg: "\(fname) \(lname) \(mobile) \(email) \(password) \(confirm)")
            vmSignUp.signUp(firstName: fname, lastName: lname, mobile: mobile, email: email, password: password)
        }
        
    }
    
}
