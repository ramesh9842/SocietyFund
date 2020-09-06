//
//  EditProfileViewController.swift
//  SocietyFund
//
//  Created by sanish on 8/31/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLName: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfGeoCode: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBAction func editProfilePressed(_ sender: UIButton) {
        validate()
    }
    var isGoodToGo = false
    var mobileErr = false
    var emailErr = false
    var profileData: ProfileModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTextFieldsWithDelegate()
        
        tfFirstName.text = profileData.firstName
        tfLName.text = profileData.lastName
        tfMobile.text = profileData.phone
        tfEmail.text = profileData.email
        setProfileImage(profileData.picture!) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.imgProfile.image = UIImage(data: data)
                case .failure:
                    self.imgProfile.image = UIImage(named: "smallLogo")
                }
            }
        }
        
    }
    
    func customTextFieldsWithDelegate() {
        tfLName.customTextField()
        tfFirstName.customTextField()
        tfGeoCode.customTextField()
        tfEmail.customTextField()
        tfMobile.customTextField()
        
        tfFirstName.delegate = self
        tfLName.delegate = self
        tfGeoCode.delegate = self
        tfMobile.delegate = self
        tfEmail.delegate = self
    }
    
    func validate() {
        guard let fname = tfFirstName.text?.trimmed, let lname = tfLName.text?.trimmed, let geocode = tfGeoCode.text?.trimmed, let mobile = tfMobile.text?.trimmed, let email = tfEmail.text?.trimmed else { return }
        
        if (fname.isEmpty || lname.isEmpty || geocode.isEmpty || mobile.isEmpty || email.isEmpty) {
            isGoodToGo = false
            alert(message: "Fields can't be empty.", title: "Empty Field!")
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
            }else{
                emailErr = true
            }
        }
        isGoodToGo = mobileErr && emailErr
        if isGoodToGo {
            editProfile(firstName: fname, lastName: lname, mobile: mobile, email: email, profileImage: "")
        }
        //        editProfile(firstName: fname, lastName: lname, mobile: geocode.append(mobile), email: email, profileImage: : UIImage(named: "somephoto"))
    }
    
    func editProfile(firstName: String, lastName: String, mobile: String, email: String, profileImage: String) {
        print(firstName,lastName,mobile,email,profileImage)
    }
    
}

// MARK: - TextFieldDelegate
extension EditProfileViewController: UITextFieldDelegate {
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

// MARK: - CountryDelegate
extension EditProfileViewController: CountryDelegate {
    func selectedCountry(country: CountryCode) {
        tfGeoCode.text = country.dialCode
    }
}
