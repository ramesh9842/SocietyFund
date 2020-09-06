//
//  SignInInteractor.swift
//  SocietyFund
//
//  Created by sanish on 9/4/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import GoogleSignIn

class SignInInteractor {

    func getDialCode(completion: ([CountryCode]) -> Void) {
        if let path = Bundle.main.url(forResource: "CountryCode", withExtension: "json") {
            print(path)
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                print(data)
                let jsonResult = try JSONDecoder().decode([CountryCode].self, from: data)
                completion(jsonResult)
              } catch {
                Log.debug(msg: error)
              }
        }else {
            print("path nil")
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
