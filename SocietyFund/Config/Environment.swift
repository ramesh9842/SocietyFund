//
//  Environment.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//
import Foundation

import Foundation

public enum PlistKey {
    case TestApi
    case BaseUrl
    case BaseProtocol
//    case Username
//    case Password
    
    
    func value() -> String {
        switch self {
        case .TestApi:
            return "test_api"
        case .BaseProtocol:
            return "base_protocol"
        case .BaseUrl:
            return "base_url"
        
//        case .BaseConnectionProtocol:
//            return "base_protocol"
//        case .FonepayRewardSystemBaseUrl:
//            return "fonepay_reward_system_base_url"
//        case .Username:
//            return "username"
//        case .Password:
//            return "password"
        }
    }
}
public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            } else {
                fatalError("Plist file not found")
            }
        }
    }
    public func configuration(_ key: PlistKey) -> Any {
        switch key {
        case .TestApi:
            return infoDict[PlistKey.TestApi.value()] as! Bool
        case .BaseProtocol:
            return infoDict[PlistKey.BaseProtocol.value()] as! String
        case .BaseUrl:
            return (infoDict[PlistKey.BaseProtocol.value()] as! String + "://" + (infoDict[PlistKey.BaseUrl.value()] as! String))
//        case .FonepayRewardSystemBaseUrl:
//            return (infoDict[PlistKey.BaseConnectionProtocol.value()] as! String) + "://" + (infoDict[PlistKey.FonepayRewardSystemBaseUrl.value()] as! String)
//
//        case .Username:
//            return infoDict[PlistKey.Username.value()] as! String
//
//        case .Password:
//            return infoDict[PlistKey.Password.value()] as! String
        }
    }
}
