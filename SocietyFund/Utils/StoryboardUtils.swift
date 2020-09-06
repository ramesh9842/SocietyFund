//
//  StoryboardUtils.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class StoryboardUtils: UIViewController {
}

extension UIStoryboard {
    
    class var login: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    
    class var settings: UIStoryboard {
        return UIStoryboard(name: "Settings", bundle: nil)
    }
    
    class var sms: UIStoryboard {
        return UIStoryboard(name: "SmsHome", bundle: nil)
    }
    
    class var dashboard: UIStoryboard {
        return UIStoryboard(name: "Dashboard", bundle: nil)
    }
    
    class var message: UIStoryboard {
        return UIStoryboard(name: "Message", bundle: nil)
    }
    
    class var smsBankAccount: UIStoryboard {
        return UIStoryboard(name: "SmsBankAccount", bundle: nil)
    }
    
    class var authentication: UIStoryboard {
        return UIStoryboard(name: "Authentication", bundle: nil)
    }
    
    class var userProfile: UIStoryboard {
        return UIStoryboard(name: "UserProfile", bundle: nil)
    }
    
    class var confirmation: UIStoryboard {
        return UIStoryboard(name: "Confirmation", bundle: nil)
    }
    
    class var amountDeposite: UIStoryboard {
        return UIStoryboard(name: "AmountDeposite", bundle: nil)
    }
    
    class var linkedAccount: UIStoryboard {
        return UIStoryboard(name: "LinkedAccount", bundle: nil)
    }
    
    class var kyc: UIStoryboard {
        return UIStoryboard(name: "Kyc", bundle: nil)
    }
    
    class var statement: UIStoryboard {
        return UIStoryboard(name: "Statement", bundle: nil)
    }
    
    class var activityLog: UIStoryboard {
        return UIStoryboard(name: "ActivityLog", bundle: nil)
    }
    
    class var list: UIStoryboard {
        return UIStoryboard(name: "List", bundle: nil)
    }
    
    class var loadWallet: UIStoryboard {
        return UIStoryboard(name: "LoadWallet", bundle: nil)
    }
    
    class var airlines: UIStoryboard {
        return UIStoryboard(name: "Airlines", bundle: nil)
    }
    
    class var additionalAccount: UIStoryboard {
        return UIStoryboard(name: "AdditionalAccount", bundle: nil)
    }
    
    class var payment: UIStoryboard {
        return UIStoryboard(name: "Payment", bundle: nil)
    }
    
    
}

extension UIViewController {
    class var identifier: String {
        return String(describing: self)
    }
}

protocol StoryboardInstantiable where Self: UIViewController {
    static var storyboardIdentifier: UIStoryboard { get }
}

class ViewController<T: StoryboardInstantiable> {
    
    class func instance() -> T {
        let controller = T.storyboardIdentifier.instantiateViewController(withIdentifier: T.identifier) as! T
        return controller
    }
}

