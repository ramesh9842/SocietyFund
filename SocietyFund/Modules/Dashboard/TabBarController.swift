//
//  TabBarController.swift
//  SocietyFund
//
//  Created by sanish on 8/30/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let barButtonView = item.value(forKey: "view") as? UIView else { return }
        
        let animationLength: TimeInterval = 0.3
        let propertyAnimator = UIViewPropertyAnimator(duration: animationLength, dampingRatio: 0.5) {
            barButtonView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }
        propertyAnimator.addAnimations({ barButtonView.transform = .identity }, delayFactor: CGFloat(animationLength))
        propertyAnimator.startAnimation()
    }

}
