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
//    @IBOutlet weak var btnPrevious: UIButton!
//    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var lblActive: UILabel!
    @IBOutlet weak var lblSupporters: UILabel!
    @IBOutlet weak var lblRaisedStat: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblProjectDesc: UILabel!
    
}
