//
//  PriceMapCollectionViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/26.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class PriceMapCollectionViewCell: UICollectionViewCell {
    
    weak var goPageDelegate:GoPageDelegate?
    @IBOutlet weak var priceImageView: UIImageView!
    @IBOutlet weak var pointLable: UILabel!
    @IBOutlet weak var imageTraillingContrant: NSLayoutConstraint!
    @IBAction func goPriceAction(sender: AnyObject) {
        goPageDelegate?.goPage(1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
