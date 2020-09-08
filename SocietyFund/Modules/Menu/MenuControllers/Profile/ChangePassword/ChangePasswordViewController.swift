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
    
    var validator: ChangePasswordValidator!
    var vmChangePassword: ChangePasswordViewModel!
    
    @IBAction func changePasswordPressed(_ : UIButton) {
        validator.validate(tfOldPassword: tfOldPassword, tfNewPassword: tfNewPassword, tfConfirmPassword: tfConfirmPassword)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextFields()
        vmChangePassword = ChangePasswordViewModel()
        validator = ChangePasswordValidator(vm: vmChangePassword)
        vmChangePassword.delegate = self
        validator.delegate = self
    }
    
    func customizeTextFields() {
        tfOldPassword.customTextField()
        tfNewPassword.customTextField()
        tfConfirmPassword.customTextField()
    }
    
}

// MARK: - ChangePasswordDelegate

extension ChangePasswordViewController: ChangePasswordDelegate {
    func onSuccess(_ response: ChangePasswordResponse) {
        Log.debug(msg: response)
    }
    
    func onFailure(msg: String, title: String) {
        alert(message: msg, title: title)
    }
}
