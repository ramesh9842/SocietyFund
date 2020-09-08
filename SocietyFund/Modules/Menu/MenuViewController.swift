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

class MenuViewController: UIViewController {
    
    @IBOutlet weak var btnViewProfile: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var profileData: ProfileModel!
    var menuData = [MenuModel]()
    var menuVM: MenuViewModel!
    
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
        menuVM = MenuViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let result = menuVM.userLoggedIn()
        if result.1 {
            
            profileData = result.0
            Log.debug(msg: "User logged In..")
            lblUserName.isHidden = false
            btnViewProfile.setTitle("View Profile", for: .normal)
            btnViewProfile.tag = 1
            lblUserName.text = self.profileData.name!
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
            self.tableView.tableViewCellForLastRow()?.isHidden = false
            
        }else {
            
            lblUserName.isHidden = true
            btnViewProfile.setTitle("Sign In", for: .normal)
            imgProfile.image = UIImage(named: "smallLogo")
            btnViewProfile.tag = 0
            self.tableView.tableViewCellForLastRow()?.isHidden = true
            
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
        menuVM.navigateToMenuViewControllers(menuSelected: selectedMenu)
        
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

/*
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
 */
