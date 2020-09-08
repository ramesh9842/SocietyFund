//
//  EditProfileInputValidator.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

protocol EditProfileDelegate: class {
    func onSuccess(_ response: EditProfileResponse)
    func onFailure(msg: String, title: String)
}

class EditProfileInputValidator {
    
    var isGoodToGo = false
    var mobileErr = false
    var emailErr = false
    var vmEditProfile: EditProfileViewModel!
    var delegate: EditProfileDelegate?
    
    init(vm: EditProfileViewModel) {
        self.vmEditProfile = vm
    }
    
    func validate(tfFirstName: UITextField, tfLName: UITextField, tfGeoCode: UITextField, tfMobile: UITextField,tfEmail: UITextField) {
        guard let fname = tfFirstName.text?.trimmed, let lname = tfLName.text?.trimmed, let geocode = tfGeoCode.text?.trimmed, let mobile = tfMobile.text?.trimmed, let email = tfEmail.text?.trimmed else { return }
        
        if (fname.isEmpty || lname.isEmpty || geocode.isEmpty || mobile.isEmpty || email.isEmpty) {
            isGoodToGo = false
            delegate?.onFailure(msg: "Fields can't be empty.", title: "Empty Field!")
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
            }else{
                emailErr = true
            }
        }
        isGoodToGo = mobileErr && emailErr
        if isGoodToGo {
            vmEditProfile.editProfile(firstName: fname, lastName: lname, mobile: mobile, email: email, profileImage: "")
        }
        //        editProfile(firstName: fname, lastName: lname, mobile: geocode.append(mobile), email: email, profileImage: : UIImage(named: "somephoto"))
    }
    
}
