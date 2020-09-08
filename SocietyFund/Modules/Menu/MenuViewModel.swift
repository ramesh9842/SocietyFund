//
//  MenuViewModel.swift
//  SocietyFund
//
//  Created by sanish on 9/7/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit


class MenuViewModel {
    
    func navigateToMenuViewControllers(menuSelected: String) {
        guard let selectedVC = (mmDrawerContainer?.centerViewController as? TabBarController)?.selectedViewController as? UINavigationController else {
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if menuSelected == "Notifications" {
            let vc = storyboard.instantiateViewController(withIdentifier: "NotificationViewController")
            selectedVC.pushViewController(vc, animated: true)
            mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
        }else if menuSelected == "Refer and Raise" {
            let vc = storyboard.instantiateViewController(withIdentifier: "ReferViewController")
            selectedVC.pushViewController(vc, animated: true)
            mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
        }else if menuSelected == "Contact Us" {
            selectedVC.tabBarController?.selectedIndex = 3
            mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
        }else if menuSelected == "Settings"{
            let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController")
            selectedVC.pushViewController(vc, animated: true)
            mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
        }else if menuSelected == "Logout"{
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
            //            if let token = AccessToken.current, !token.isExpired{
            //                Log.debug(msg: "Loggin out Facebook User: \(token.userID) ")
            //                LoginManager().logOut()
            //            }else {
            //                if let current = GIDSignIn.sharedInstance()?.currentUser {
            //                    Log.debug(msg: "Loggin out Google User: \(current.userID) ")
            //                    isGoogleSignedIn = false
            //                    GIDSignIn.sharedInstance().signOut()
            //                }
            //            }
            let vc = (mmDrawerContainer?.centerViewController as? TabBarController)?.viewControllers?.first?.children
            vc?.first?.viewWillAppear(true)
            mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
        }else if(menuSelected == "Bank" || menuSelected == "KYC"){
            
        }else {
            Log.debug(msg: "UNDER CONSTRUcTIon!!!")
            mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
        }
        
    }
    
    func userLoggedIn() -> (ProfileModel?, Bool) {
        if let data = UserDefaults.standard.data(forKey: "profile") {
            do {
                let profileData = try JSONDecoder().decode(ProfileModel.self, from: data)
                return (profileData, true)
            }catch{
                Log.debug(msg: "Error decoding value!!")
            }
        }else {
            return(nil, false)
        }
        return (nil,false)
    }
    
}

