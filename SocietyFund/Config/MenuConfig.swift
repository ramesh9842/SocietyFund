//
//  MenuConfig.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

public class MenuConfig {
    
    public static var SMS_TOTAL_DEPOSITE = "TOTAL_DEPOSITE"
    public static var SMS_ACTIVITY_LOGS = "SMS_ACTIVITY_LOGS"
    public static var SMS_MY_STSTEMENT = "SMS_MY_STSTEMENT"
    public static var SMS_INQUIRE = "SMS_INQUIRE"
    public static var SMS_PIN_CHANGE = "SMS_PIN_CHANGE"
    public static var SMS_REGISTRATION = "REGISTRATION"
    public static var SMS_SMART_DEPOSITE = "SMART_DEPOSITE"
    public static var SMS_TOPUP_PAYMENT = "TOPUP_PAYMENT"
    public static var SMS_SMART_WALLET = "SMART_WALLET"
    public static var SMS_WALLET_TOPUP = "WALLET_TOPUP"
    public static var SMS_SMART_REMIT_P2P = "SMART_REMIT_P2P"
    public static var SMS_ABOUT_US = "SMS_ABOUT_US"
    public static var SMS_FAQS = "SMS_FAQS"
    public static var SMS_CSR = "SMS_CSR"
    public static var SMS_PRIVACY_POLICY = "SMS_PRIVACY_POLICY"
    public static var SMS_USER_MANUAL = "SMS_USER_MANUAL"
    public static var SMS_MEMBER_BANK = "SMS_MEMBER_BANK"
    public static var SMS_NOTIES = "SMS_NOTIES"
    public static var DEPOSITE_BY_WALLET = "DEPOSITE_BY_WALLET"
    public static var DEPOSITE_BY_SCRATCH_CARD = "DEPOSITE_BY_SCRATCH_CARD"
    public static var SMART_DEPOSITE_BY_WALLET = "SMART_DEPOSITE_BY_WALLET"
    public static var SMART_DEPOSITE_BY_SCRATCH_CARD = "SMART_DEPOSITE_BY_SCRATCH_CARD"
    public static var ABOUT_US = "ABOUT_US"
    public static var MEMBER_BANK = "MEMBER_BANK"
    public static var CSR = "CSR"
    public static var SMART_REMIT = "SMART_REMIT"
    public static var RECHARGE_CARD = "RECHARGE_CARD"
    public static var MOBILE_BANKING = "MOBILE_BANKING"
    public static var INTERNET_BANKING = "INTERNET_BANKING"
    public static var LOAD_VIA_IPS = "LOAD_VIA_IPS"
    public static var LOAD_VIA_RECHARGE_CARD = "LOAD_VIA_RECHARGE_CARD"
    public static var PAYMENT_FORM = "PAYMENT_FORM"
    public static var AIRLINES_PERSONAL_DETAIL_FORM = "AIRLINES_PERSONAL_DETAIL_FORM"
    
    
}

struct MenuModel {
    var opened: Bool
    var title: String
    var sectionData: [String]?
    var image: UIImage
}

enum Menu: String, CaseIterable {
    case notifications, about, contact, website,bank, project, kyc, refer, donation, setting, logout
    
    var components: MenuModel {
        switch self {
        case .notifications:
            return MenuModel(opened: false, title: "Notifications", sectionData: nil, image: UIImage(named: "notification")!)
        case .about:
           return MenuModel(opened: false, title: "About Us", sectionData:nil, image: UIImage(named: "about")!)
        case .contact:
            return MenuModel(opened: false, title: "Contact Us", sectionData: nil, image: UIImage(named: "contact")!)
        case .website:
           return MenuModel(opened: false, title: "Go to Website", sectionData: nil, image: UIImage(named: "website")!)
        case .bank:
            return MenuModel(opened: false, title: "Bank", sectionData: ["View Bank Account", "Submit Bank Account"], image: UIImage(named: "bank")!)
        case .project:
           return MenuModel(opened: false, title: "Projects", sectionData: nil, image: UIImage(named: "project")!)
        case .kyc:
           return MenuModel(opened: false, title: "KYC", sectionData: ["View KYC", "Submit KYC"], image: UIImage(named: "kyc")!)
        case .refer:
           return MenuModel(opened: false, title: "Refer and Raise", sectionData: nil, image: UIImage(named: "refer&earn")!)
        case .donation:
            return MenuModel(opened: false, title: "Donation", sectionData: nil, image: UIImage(named: "donate")!)
        case .setting:
            return MenuModel(opened: false, title: "Settings", sectionData: nil, image: UIImage(named: "setting")!)
        case .logout:
            return MenuModel(opened: false, title: "Logout", sectionData: nil, image: UIImage(named: "logout")!)
        }
    }
}

enum Settings: String, CaseIterable {
    case account = "Account"
    case bankaccount = "Bank Account"
    case notification = "Notifications"
    case devices = "Devices"
    case password = "Password"
    case kycform = "KYC Form"
    case applicationform = "Application Form"
    
    var image: UIImage? {
        switch self {
        case .account:
            return UIImage(named: "kyc") ?? nil
        case .bankaccount:
           return UIImage(named: "bank") ?? nil
        case .notification:
            return UIImage(named: "notification") ?? nil
        case .devices:
          return UIImage(named: "notification") ?? nil
        case .password:
            return UIImage(named: "notification") ?? nil
        case .kycform:
           return UIImage(named: "notification") ?? nil
        case .applicationform:
            return UIImage(named: "notification") ?? nil
        }
    }
}

