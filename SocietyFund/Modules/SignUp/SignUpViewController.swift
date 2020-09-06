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
    var isGoodToGo = false
    var mobileErr = false
    var emailErr = false
    var passwordErr = false
    var confirmErr = false
    
    @IBAction func signUpPressed(_ : UIButton) {
        validate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tfGeoCode.delegate = self
        customizeButtons()
        setDelegate()
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
    
    func validate() {
        guard let fname = tfFName.text?.trimmed, let lname = tfLName.text?.trimmed, let geocode = tfGeoCode.text?.trimmed, let mobile = tfMobile.text?.trimmed, let email = tfEmail.text?.trimmed, let password = tfPassword.text?.trimmed, let confirm = tfConfirm.text?.trimmed  else { return }
        
        if (fname.isEmpty || lname.isEmpty || geocode.isEmpty || mobile.isEmpty || email.isEmpty || password.isEmpty || confirm.isEmpty) {
            alert(message: "Fields can't be empty.", title: "Empty Field!")
            isGoodToGo = false
        }else {
            if(!mobile.isValidRegEx(.phoneNo)) {
                 alert(message: "e.g. 9810219190", title: "Invalid Mobile Number!")
                mobileErr = false
            }else {
                mobileErr = true
            }
            if(!email.isValidRegEx(.email)) {
              alert(message: "e.g. mike@hello.com", title: "Invalid Email!")
                emailErr = false
            }else {
                emailErr = true
            }
            if(!password.isValidRegEx(.password)) {
                alert(message: "Password Length 6-15 characters.", title: "Invalid Password Format!")
                passwordErr = false
            }else {
                passwordErr = true
            }
            if(password != confirm) {
                alert(message: "Enter same password", title: "Password Mismatch!")
                confirmErr = false
            }else{
                confirmErr = true
            }
        }
        isGoodToGo = mobileErr && emailErr && passwordErr && confirmErr
        if isGoodToGo {
            signUp(firstName: fname, lastName: lname, mobile: mobile, email: email, password: password)
        }
        
//        signUp(firstName: fname, lastName: lname, mobile: geocode.append(mobile), email: email, password: password)
    }
    
    func signUp(firstName: String, lastName: String, mobile: String, email: String, password: String) {
        print(firstName,lastName,mobile,email,password)
        // https://run.mocky.io/v3/c5c6dc03-dd81-45dc-985d-e6cb01a4b07f
        let params = ["firstName": firstName, "lastName": lastName, "mobile": mobile, "email": email, "password": password]
        APIService.shared.request("https://run.mocky.io/v3/01320520-366a-41e0-a421-df5c7b7a6ab7", method: .POST, params: params) { [weak self](result: (Result<Any, APIError>)) in
            print(result)
            switch result {
            case .success(let singUpResponse):
                let message = (singUpResponse as! [String: Any])
                Log.debug(msg: message["responseCode"] as! Int)
                
            case .failure(let error):
                self?.alert(message: error.rawValue)
            }
        }
        
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
