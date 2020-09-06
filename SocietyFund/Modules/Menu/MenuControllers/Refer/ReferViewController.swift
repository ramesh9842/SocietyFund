//
//  ReferViewController.swift
//  SocietyFund
//
//  Created by sanish on 9/1/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class ReferViewController: UIViewController {
    @IBOutlet weak var tfSelectProject: UITextField!
    @IBOutlet weak var tfProjectLink: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeTextFields()

    }
    
    func customizeTextFields() {
        tfSelectProject.customTextField()
        tfProjectLink.customTextField()
    }

}
