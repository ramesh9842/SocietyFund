//
//  TrendingCollectionCell.swift
//  SocietyFund
//
//  Created by sanish on 8/29/20.
//  Copyright © 2020 AahamSolutions. All rights reserved.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var lblProjectDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
