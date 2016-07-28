//
//  ImagePriceCollectionViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/28.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class ImagePriceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagePriceView: UIView!
    @IBOutlet weak var viewForShadow: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewForShadow.layer.shadowColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1).CGColor
        viewForShadow.layer.shadowOpacity = 3
        viewForShadow.layer.shadowOffset = CGSizeZero
        viewForShadow.layer.shadowRadius = 3
        viewForShadow.layer.shouldRasterize = true


    }

}
