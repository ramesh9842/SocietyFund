//
//  SettingsViewController.swift
//  SocietyFund
//
//  Created by sanish on 8/31/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit
import MMDrawerController

struct SettingList {
    var image: UIImage!
    var title: String!
}

class SettingsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var list: [[SettingList]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = 44
        list = [[SettingList(image: UIImage(named: "account"), title: "Account"), SettingList(image: UIImage(named: "bank"), title: "Bank Account")],[SettingList(image: UIImage(named: "notification"), title: "Notifications"), SettingList(image: UIImage(named: "notification"), title: "Devices")]]
    }
    
    func navigateToMenuViewControllers(menuSelected: String) {
       
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?[section].count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingCell
        let section = list?[indexPath.section]
        cell.accessoryView?.tintColor = .black
        cell.lblSetting.text = section?[indexPath.row].title
        cell.imgSetting.image = section?[indexPath.row].image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: selectedIndex!) as! SettingCell
        print(cell.lblSetting.text)
    }
    
}



class SettingCell: UITableViewCell {
    @IBOutlet weak var lblSetting: UILabel!
    @IBOutlet weak var imgSetting: UIImageView!
}

