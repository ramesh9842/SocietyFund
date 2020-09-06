//
//  UIView+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

extension UIView {
    
    func cutomizeButtonView() {
        self.setCorner(no: 10)
        self.backgroundColor = ColorConfig.ButtonPrimary
    }
    
    func setCorner(no: CGFloat) {
        self.layer.cornerRadius = no
        self.layer.masksToBounds = true
    }
    
    func setCustomCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setBackgroundColor(color: UIColor) {
        self.backgroundColor = color
    }
    
    func setBorderColor(color: CGColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 8
    }
    
    func setCustomizedShadow(color: CGColor, opacity: Float, radius: CGFloat){
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
    }
    
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }
    
    func applyCornerRadiusAndShadow() {
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor(red: 27/255, green: 36/255, blue: 39/255, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func afterViewSets() {
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func gradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientColor: CAGradientLayer = CAGradientLayer()
        gradientColor.frame = self.frame.bounds
        let colorOne: CGColor = colorTop.cgColor
        let colorTwo: CGColor = colorBottom.cgColor
        gradientColor.colors = [colorOne, colorTwo]
        self.layer.insertSublayer(gradientColor, at: 0)
    }
    
    func gradientBackgroundHorizontal(colorTop: UIColor, colorBottom: UIColor) {
        let gradientColor: CAGradientLayer = CAGradientLayer()
        gradientColor.frame = self.frame.bounds
        gradientColor.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientColor.endPoint = CGPoint(x: 1.0, y: 1.0)
        let colorOne: CGColor = colorTop.cgColor
        let colorTwo: CGColor = colorBottom.cgColor
        gradientColor.colors = [colorOne, colorTwo]
        self.layer.insertSublayer(gradientColor, at: 0)
        
    }
}


