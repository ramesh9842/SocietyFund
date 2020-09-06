//
//  UIImage+Extensions.swift
//  SocietyFund
//
//  Created by sanish on 8/28/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

extension UIImage {
    func setIconTint(icon: UIImage, color: UIColor) -> UIImage {
        let imageView = UIImageView(image: self.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = color
        return imageView.image!
    }
    
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
