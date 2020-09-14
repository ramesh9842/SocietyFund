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
    @IBOutlet weak var viewProfile: UIView!
    
    @IBAction func editProfilePressed(_ sender: UIButton) {
        validator.validate(tfFirstName: tfFirstName, tfLName: tfLName, tfGeoCode: tfGeoCode, tfMobile: tfMobile, tfEmail: tfEmail, imgProfile: imgProfile)
    }
    
    var editprofileVM: EditProfileViewModel!
    var validator: EditProfileInputValidator!
    var profileData: ProfileModel!
    var imagePicker: ImagePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTextFieldsWithDelegate()
        setUpView()
        editprofileVM = EditProfileViewModel()
        validator = EditProfileInputValidator(vm: editprofileVM)
        validator.delegate = self
        editprofileVM.delegate = self
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        addTapGesture()
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(uploadProfileImage(_:)))
        viewProfile.isUserInteractionEnabled = true
        tap.numberOfTouchesRequired = 1
        viewProfile.addGestureRecognizer(tap)
    }
    
    @objc func uploadProfileImage(_ sender: UITapGestureRecognizer) {
        Log.debug(msg: "tapped")
        self.imagePicker.present(from: self.view)
    }
    
    func setUpView() {
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
    
}

// MARK: - ImagePickerDelegate

extension EditProfileViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        Log.debug(msg: "Setting Image")
        imgProfile.image = image
    }
    
}

// MARK: - EditProfileDelegate
extension EditProfileViewController: EditProfileDelegate {
    func onSuccess(_ response: EditProfileResponse) {
        Log.debug(msg: response)
    }
    
    func onFailure(msg: String, title: String) {
        alert(message: msg, title: title)
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
