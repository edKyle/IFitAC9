//
//  PriceViewCurrentPointCollectionViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/26.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class PriceViewCurrentPointCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var targetLable: UILabel!
    @IBOutlet weak var currentPointLable: UILabel!
    @IBOutlet weak var progressBar: MBCircularProgressBarView!
    @IBOutlet weak var itemWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

}
