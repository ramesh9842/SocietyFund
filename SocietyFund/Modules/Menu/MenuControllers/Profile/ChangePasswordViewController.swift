//
//  ChangePasswordViewController.swift
//  SocietyFund
//
//  Created by sanish on 8/31/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var tfOldPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBAction func changePasswordPressed(_ : UIButton) {
        validate()
    }
    var isGoodToGo = false
    var passwordErr = false
    var confirmErr = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfOldPassword.customTextField()
        tfNewPassword.customTextField()
        tfConfirmPassword.customTextField()
    }
    
    func validate() {
        guard let oldPassword = tfOldPassword.text?.trimmed, let newPassword = tfNewPassword.text?.trimmed, let confirmPassword = tfConfirmPassword.text?.trimmed else { return }
        
        if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
            alert(message: "Fields can't be empty.", title: "Empty Field!")
            isGoodToGo = false
        }else {
            if(!newPassword.isValidRegEx(.password)) {
                 alert(message: "Password Length 6-15 characters.", title: "Invalid Password Format!")
                 confirmErr = false
            }else {
                passwordErr = true
            }
            if(newPassword != confirmPassword) {
              alert(message: "Enter same password", title: "Password Mismatch!")
                confirmErr = false
            }else {
                confirmErr = true
            }
        }
        isGoodToGo = passwordErr && confirmErr
        if isGoodToGo {
            changePassword(newPassword: newPassword)
        }
    }
    
    func changePassword(newPassword: String) {
            
    }

}
