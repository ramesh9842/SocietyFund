//
//  MenuViewController.swift
//  SocietyFund
//
//  Created by sanish on 8/30/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit
import MMDrawerController
import SDWebImage
import FBSDKLoginKit
import GoogleSignIn

protocol MenuViewProtocol {
    
}

extension MenuViewController: MenuViewProtocol {
    
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var btnViewProfile: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var profileData: ProfileModel!
    var menuData = [MenuModel]()
    var presenter: MenuPresenterProtocol?

    @IBAction func viewProfilePressed(_ sender: UIButton) {
        guard let selectedVC = (mmDrawerContainer?.centerViewController as? TabBarController)?.selectedViewController as? UINavigationController else {
            return
        }
        if sender.tag == 0 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
            selectedVC.pushViewController(vc!, animated: true)
        }else {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
            vc?.profileData = profileData
            selectedVC.pushViewController(vc!, animated: true)
        }
        mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 44
        navigationController?.isNavigationBarHidden = true
        menuData = [Menu.notifications.components, Menu.about.components, Menu.contact.components, Menu.website.components, Menu.bank.components, Menu.project.components, Menu.kyc.components, Menu.refer.components, Menu.donation.components, Menu.setting.components, Menu.logout.components]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setUpFacebookUser()
        userLoggedIn()
    }
    
    func userLoggedIn() {
        Log.debug(msg: "User logged In..")
        lblUserName.isHidden = false
        btnViewProfile.setTitle("View Profile", for: .normal)
        btnViewProfile.tag = 1
        if let data = UserDefaults.standard.data(forKey: "profile") {
            do {
                profileData = try JSONDecoder().decode(ProfileModel.self, from: data)
                lblUserName.text = self.profileData?.name
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
            } catch {
                print("Unable to Decode Note (\(error))")
            }
            self.tableView.tableViewCellForLastRow()?.isHidden = false
        }else {
            userLoggedOut()
        }
    }
    
    func userLoggedOut() {
        lblUserName.isHidden = true
        btnViewProfile.setTitle("Sign In", for: .normal)
        imgProfile.image = UIImage(named: "smallLogo")
        btnViewProfile.tag = 0
        self.tableView.tableViewCellForLastRow()?.isHidden = true
    }
    
    func setUpFacebookUser() {
        if let token = AccessToken.current, !token.isExpired{
            userLoggedIn()
        }else {
            if (GIDSignIn.sharedInstance()?.currentUser) != nil {
                userLoggedIn()
            }else {
              userLoggedOut()
            }
        }
    }
    
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
            alert(message: "Under Construction!!!")
            mmDrawerContainer?.toggle(.left, animated: true, completion: nil)
        }
        
    }
}

// MARK: - TableViewDelegate
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if menuData[section].opened == true {
            return (menuData[section].sectionData?.count ?? 0) + 1
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        if indexPath.row == 0 {
            cell.lblMenu.text = menuData[indexPath.section].title
            cell.imgMenu.image = menuData[indexPath.section].image
            if menuData[indexPath.section].sectionData != nil {
                cell.imgUpDown.image = UIImage(named: "show")
            }else {
                cell.imgUpDown.image = nil
            }
            return cell
        }else {
            cell.lblMenu.text = menuData[indexPath.section].sectionData?[indexPath.row - 1]
            cell.imgMenu.image = nil
            cell.imgUpDown.image = nil
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: selectedIndex!) as! MenuCell
        guard let selectedMenu =  cell.lblMenu.text else { return }
        navigateToMenuViewControllers(menuSelected: selectedMenu)
        
        if menuData[indexPath.section].opened == true {
            menuData[indexPath.section].opened = false
            let sections = IndexSet(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }else {
            menuData[indexPath.section].opened = true
            let sections = IndexSet(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
}

// MARK:- MenuCell
class MenuCell: UITableViewCell {
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var imgUpDown: UIImageView!
}
