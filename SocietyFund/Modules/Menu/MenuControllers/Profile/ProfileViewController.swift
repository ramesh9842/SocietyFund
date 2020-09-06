//
//  ProfileViewController.swift
//  SocietyFund
//
//  Created by sanish on 8/31/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var profileData: ProfileModel!
    @IBAction func btnEditProfilePressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        vc.profileData = profileData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnChangePasswordPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblFirstName.text = profileData.firstName
        lblLastName.text = profileData.lastName
        lblEmail.text = profileData.email
        lblMobile.text = profileData.phone
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
    
}

