//
//  UIImageView+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func tintColor(color: UIColor) {
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }

    
    func setIconRender(image: UIImage, color: UIColor) {
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
    
    func makeItRounded() {
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func setImageUrl(_ url: String?) {
        if let setUrl = url {
            let url = URL(string: setUrl)
            self.sd_setImage(with: url, completed: nil)
        }
    }
    
     
}
