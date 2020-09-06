//
//  UIButton+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//
//

import UIKit

extension UIButton {
    func setTextColor(color: UIColor) {
      self.setTitleColor(color, for: .normal)
    }
    
    func setIconTint(color: UIColor) {
        let iconRender = self.imageView?.image!.withRenderingMode(.alwaysTemplate)
        self.setImage(iconRender, for: .normal)
        self.tintColor = color
    }
    
    func setBtnCorner(no: CGFloat) {
        self.layer.cornerRadius = no
        self.layer.masksToBounds = true
    }
    
    func setBtnBorderColor(color: CGColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
    

    func setBtnImage(imageName: String) {
        let fetchedImage = UIImage(named: imageName)
        self.setImage(fetchedImage, for: .normal)
    }
    
    func setImageEdge(no: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: no, left: no, bottom: no, right: no)
    }
    

//    func setGradientBackgroundBtn(colorTop: UIColor, colorBottom: UIColor){
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//        gradientLayer.locations = [0, 1]
//        gradientLayer.frame = bounds
//        
//        layer.insertSublayer(gradientLayer, at: 0)
//    }

}
