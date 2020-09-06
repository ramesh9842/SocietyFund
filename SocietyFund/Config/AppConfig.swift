//
//  AppConfig.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import Foundation
import UIKit

class AppConfig {
    
    public static let TEST_USERNAME = "test@smartcardnepal.com"
    public static let TEST_PASSWORD = "sanish@123"
   
    
    public static let TEST_API = Environment().configuration(PlistKey.TestApi) as? Bool ?? true

    public static let BASE_URL = Environment().configuration(PlistKey.BaseUrl) as? String ?? ""
//    public static let SOCKET_URL = Environment().configuration(PlistKey.SocketUrl) as? String ?? ""
//    public static let FONEPAY_REWARD_SYSTEM_BASE_URL = Environment().configuration(PlistKey.FonepayRewardSystemBaseUrl) as? String ?? ""
    
    public static let RECAPTCHA_API_KEY = "6LdE-hkUAAAAAKWfpXjXrsLMwDc0psCcjvpBgGr6"
    public static let FONEPAY_OFFERS_URL = "https://www.fonepay.com/offer-promo"
    
    public static let WEB_BASE_URL = "https://www.smartcardnepal.com.np/api/"
    public static let FAQ = WEB_BASE_URL + "getpage/faqs"
    public static let ABOUT_US = WEB_BASE_URL + "getpage/about-us"
    public static let PRIVACY_POLICY = WEB_BASE_URL + "getpage/privacy-policy"
    public static let USER_GUIDE = WEB_BASE_URL + "etpage/user-manual"
    public static let CSR  = WEB_BASE_URL + "getpage/csr"
    public static let NOTICE = WEB_BASE_URL + "getnotices"
    static var deviceId =  UIDevice.current.identifierForVendor!
}
