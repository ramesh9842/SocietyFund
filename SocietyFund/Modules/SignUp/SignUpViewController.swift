//
//  SignUpViewController.swift
//  SocietyFund
//
//  Created by sanish on 9/1/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var tfFName: UITextField!
    @IBOutlet weak var tfLName: UITextField!
    @IBOutlet weak var tfGeoCode: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfConfirm: UITextField!
    
    var signUpVM: SignUpViewModel!
    var validator: SignUpInputValidator!
    
    @IBAction func signUpPressed(_ : UIButton) {
        validator.validate(tfFName: tfFName, tfLName: tfLName, tfGeoCode: tfGeoCode, tfMobile: tfMobile, tfEmail: tfEmail, tfPassword: tfPassword, tfConfirm: tfConfirm)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfGeoCode.delegate = self
        customizeButtons()
        setDelegate()
        signUpVM = SignUpViewModel()
        validator = SignUpInputValidator(vm: signUpVM)
        signUpVM.delegate = self
        validator.delegate = self
    }
    
    func customizeButtons() {
        tfFName.customTextField()
        tfLName.customTextField()
        tfGeoCode.customTextField()
        tfMobile.customTextField()
        tfEmail.customTextField()
        tfPassword.customTextField()
        tfConfirm.customTextField()
    }
    
    func setDelegate() {
        tfFName.delegate = self
        tfLName.delegate = self
        tfGeoCode.delegate = self
        tfMobile.delegate = self
        tfEmail.delegate = self
        tfPassword.delegate = self
        tfConfirm.delegate = self
    }
    
}

// MARK: - SignUpDelegate
extension SignUpViewController: SignUpDelegate {
    func onSuccess(_ response: SignUpResponse) {
        Log.debug(msg: response.message)
        alert(message: response.message, title: "")
    }
    
    func onFailure(msg: String, title: String) {
        alert(message: msg, title: title)
    }
}

//MARK: - TextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 3 {
            textField.resignFirstResponder()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchCountryViewController") as! SearchCountryViewController
            vc.delegate = self
            present(vc, animated: false, completion: nil)
        }
    }
}

//MARK: - CountryDelegate
extension SignUpViewController: CountryDelegate {
    func selectedCountry(country: CountryCode) {
        tfGeoCode.text = country.dialCode
    }
}
