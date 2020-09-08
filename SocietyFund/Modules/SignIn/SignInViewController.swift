//
//  SignInViewController.swift
//  SocietyFund
//
//  Created by sanish on 9/1/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit
import Alamofire
import MMDrawerController
import FBSDKLoginKit
import SDWebImage
import GoogleSignIn

class SignInViewController: UIViewController {
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblLoginWith: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewFb: UIView!
    @IBOutlet weak var viewGoogle: UIView!
    
    var signInVM: SignInViewModel?
    var loginButton: FBLoginButton!
    var validator: InputValidator!
    @IBAction func signInClicked(_ sender: UIButton) {
        
        validator.validate(tfMobile: tfMobile, tfPassword: tfPassword)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeButtons()
        setDelegate()
        addTapGesture()
        signInVM = SignInViewModel()
        validator = InputValidator(vm: signInVM!)
        validator.delegate = self
        signInVM?.delegate = self
    }
    
    func addTapGesture() {
        
        let tapFacebook = UITapGestureRecognizer(target: self, action: #selector(fbLoginClicked))
        tapFacebook.numberOfTouchesRequired = 1
        viewFb.addGestureRecognizer(tapFacebook)
        let tapGoogle = UITapGestureRecognizer(target: self, action: #selector(googleLoginClicked))
        tapGoogle.numberOfTouchesRequired = 1
        viewGoogle.addGestureRecognizer(tapGoogle)
        
    }
    
    @objc func fbLoginClicked() {
        
        signInVM?.performFacebookLoginRequest(self, completion: { (result) in
            switch result {
            case .success(let result):
                self.navigationController?.popViewController(animated: result)
            case .failure(let error):
                Log.debug(msg: "FacebookLoginError: \(error)")
                break
            }
        })
        
    }
    
    @objc func googleLoginClicked() {
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
        
    }
    
    func setDelegate() {
        
        tfMobile.delegate = self
        tfPassword.delegate = self
        
    }
    
    func customizeButtons() {
        
        tfMobile.customTextField()
        tfPassword.customTextField()
        
    }
    
}

// MARK: - SignInDelegate
extension SignInViewController: SignInDelegate {
    func onSuccess(_ profile: ProfileModel, _ msg: String) {
        alert(message: msg, title: "")
        _ = signInVM?.saveProfile(profile: profile)
    }
    
    func onFailure(msg: String, title: String) {
        alert(message: msg, title: title)
    }
}

// MARK: - TextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - GIDSignInDelegate
extension SignInViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        let picture = user.profile.imageURL(withDimension: 200)?.absoluteString
        let phone = ""
        let profile = ProfileModel(name: fullName, firstName: givenName, lastName: familyName, picture: picture, email: email, phone: phone)
        Log.debug(msg: "\(profile)")
        _ = signInVM?.saveProfile(profile: profile)
        navigationController?.popViewController(animated: true)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
    }
    
}


// MARK: - FacebookLoginButton Test

/*
 func addFacebookButton() {
 loginButton = FBLoginButton()
 loginButton.permissions = ["public_profile", "email"]
 loginButton.delegate = self
 loginButton.addTarget(self, action: #selector(fbLoginClicked), for: .touchUpInside)
 let googleButton = UIButton()
 googleButton.titleLabel?.text = "GOogle"
 googleButton.backgroundColor = .blue
 googleButton.titleLabel?.textColor = .red
 
 let stackView = UIStackView()
 stackView.backgroundColor = .purple
 stackView.alignment = .fill
 stackView.axis = .vertical
 stackView.distribution = .fill
 stackView.spacing = 10
 stackView.heightAnchor.constraint(equalToConstant: 90).isActive = true
 stackView.addArrangedSubview(loginButton)
 stackView.addArrangedSubview(googleButton)
 view.addSubview(stackView)
 
 stackView.translatesAutoresizingMaskIntoConstraints = false
 stackView.topAnchor.constraint(equalTo: lblLoginWith.bottomAnchor, constant: 30).isActive = true
 stackView.leadingAnchor.constraint(equalTo: lblLoginWith.leadingAnchor).isActive = true
 stackView.trailingAnchor.constraint(equalTo: lblLoginWith.trailingAnchor).isActive = true
 stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
 
 }
 
 extension SignInViewController: LoginButtonDelegate {
 func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
 
 }
 
 func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
 
 }
 
 }
 
 */
