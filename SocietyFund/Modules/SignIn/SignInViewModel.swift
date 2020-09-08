//
//  SignInViewModel.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

protocol SignInDelegate: class {
    func onSuccess(_ response: ProfileModel, _ msg: String)
    func onFailure(msg: String, title: String)
}

class SignInViewModel {
    var delegate: SignInDelegate?
    func signIn(username: String, password: String){
        let params = ["username": username, "password": password]
        APIService.shared.request("https://run.mocky.io/v3/412e826c-12bc-4620-8b18-fcd5c5889d83", method: .POST, params: params) { [weak self](result: (Result<SignInResponse, APIError>)) in
            switch result {
            case .success(let signInResponse):
                self?.setProfileModel(signInResponse: signInResponse)
            case .failure(let error):
                self?.delegate?.onFailure(msg: error.rawValue, title: "")
            }
        }
    }
    
    func setProfileModel(signInResponse: SignInResponse) {
        if let profile = ModelManager().getProfileData(model: signInResponse) {
            self.delegate?.onSuccess(profile, signInResponse.message!)
        }else {
            self.delegate?.onFailure(msg: "No Profile Data", title: "")
        }
    }
    
    func performFacebookLoginRequest(_ vc: UIViewController, completion: @escaping (Result<Bool,Error>) -> Void) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile","email"], from: vc) { (handler, error) in
            if handler!.isCancelled {
                Log.debug(msg: "Cancelled")
                return
            }
            if error != nil {
                Log.debug(msg: error!)
                completion(.failure(error!))
                return
            }
            
            guard let token = AccessToken.current else { return }
            let parameters = ["fields" : "birthday, gender, first_name, last_name, name, email, verified, picture.type(large)"]
            //            let graphRequest = GraphRequest(graphPath: "/\(appId)/accounts/test-users", parameters: parameters, httpMethod: .get)
            //            graphRequest.start { (con,result, error) in
            //                Log.debug(msg: result)
            //            }
            let graphRequest = GraphRequest(graphPath: "me",parameters: parameters, tokenString: token.tokenString, version: nil, httpMethod: .get)
            graphRequest.start { (connection, result, error) in
                if error != nil {
                    completion(.failure(error!))
                    return
                }
                let confirmResult = result as! [String:Any]
                Log.debug(msg: "result:\(confirmResult)")
                let name = confirmResult["name"] as? String
                let firstName = confirmResult["first_name"] as? String
                let lastName = confirmResult["last_name"] as? String
                let phone = confirmResult["phone"] as? String
                let email = confirmResult["email"] as? String
                var picUrl: String!
                if let image = confirmResult["picture"] as? [String: Any]{
                    if let pic = image["data"] as? [String: Any]{
                        if let url = pic["url"] as? String {
                            picUrl = url
                        }
                    }
                }
                let profile = ProfileModel(name: name, firstName: firstName, lastName: lastName, picture: picUrl, email: email, phone: phone)
                let flag = self.saveProfile(profile: profile)
                completion(.success(flag))
            }
        }
    }
    
    func saveProfile(profile: ProfileModel) -> Bool {
        var flag = false
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            // Encode Note
            let data = try encoder.encode(profile)
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "profile")
            flag = true
        } catch {
            print("Unable to Encode Note (\(error))")
            flag = false
        }
        return flag
    }
    
    
}
