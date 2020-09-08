//
//  ContactViewController.swift
//  SocietyFund
//
//  Created by sanish on 9/1/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfMessage: UITextField!
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        validate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeTextFields()
        addLogoToNavigationBarItem()
    }
    
    func validate() {
        guard let fullname = tfFullName.text?.trimmed, let mobile = tfPhone.text?.trimmed, let email = tfEmail.text?.trimmed, let message = tfMessage.text?.trimmed else { return }
        
        if (fullname.isEmpty || mobile.isEmpty || email.isEmpty || message.isEmpty) {
            alert(message: "Fields can't be empty.", title: "Empty Field!")
        }else {
            if(!mobile.isValidRegEx(.phoneNo)) {
                alert(message: "e.g. 9810219190", title: "Invalid Mobile Number!")
            }
            if(!email.isValidRegEx(.email)) {
                alert(message: "e.g. mike@hello.co", title: "Invalid Email!")
            }
        }
        //        senMessage(firstName: fname, lastName: lname, mobile: geocode.append(mobile), email: email, password: password)
    }
    
    func senMessage(fullname: String, mobile: String, email: String, message: String) {
        
    }
    
    func customizeTextFields() {
        tfFullName.customTextField()
        tfEmail.customTextField()
        tfPhone.customTextField()
        tfMessage.customTextField()
    }
    
}
