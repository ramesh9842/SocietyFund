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
    
    var usernameErr = false
    var passwordErr = false
    var loginButton: FBLoginButton!
    var interactor: SignInInteractor?
    @IBAction func signInClicked(_ sender: UIButton) {
        
        validate()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //      addFacebookButton()
        customizeButtons()
        setDelegate()
        addTapGesture()
        interactor = SignInInteractor()
        
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
        
        interactor?.performFacebookLoginRequest(self, completion: { (result) in
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
    
    func validate() {
        guard let username = tfMobile.text?.trimmed, let password = tfPassword.text?.trimmed else { return }
        if (username.isEmpty) {
            alert(message: "Enter Username", title: "Empty Field!")
        }else {
            print("not empty username")
            if(username.isValidRegEx(.email)) || (username.isValidRegEx(.phoneNo)) {
                usernameErr = true
            }else {
                alert(message: "e.g. mike@fine.co/ 9810219190", title: "Invalid Username!")
            }
        }
        
        if (password.isEmpty) {
            alert(message: "Enter Password.", title: "Empty Field!")
        }else {
            print("not empty password")
            if !password.isValidRegEx(.password) {
                alert(message: "Password Length 6-15 characters.", title: "Invalid Password Format!")
            }else {
                passwordErr = true
            }
        }
        
        if(usernameErr == true && passwordErr == true){
            signIn(username: username, password: password)
        }
    }
    
    func signIn(username: String, password: String){
        print("valid data: \(username), \(password)")
        let params = ["username": username, "password": password]
        APIService.shared.request("https://cli.smartcardnepal.com/api/customer/auth", method: .POST, params: params) { [weak self](result: (Result<Any, APIError>)) in
            switch result {
            case .success(let singInResponse):
                let model = ModelManager().transform(jsonObject: singInResponse)
                Log.debug(msg: "\(model.title) \(String(describing: model.url)) \(String(describing: model.category)) \(String(describing: model.views))")
                self?.lblLoginWith.text = model.category
            case .failure(let error):
                self?.alert(message: error.rawValue)
            }
        }
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
        _ = interactor?.saveProfile(profile: profile)
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
