//
//  NewPriceCollectionViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/26.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

protocol GoPageDelegate:class {
    func goPage()
}

class NewPriceCollectionViewCell: UICollectionViewCell {

    weak var goDelegate:GoPageDelegate?
    
    @IBOutlet weak var priceDetailLable: UILabel!
    @IBOutlet weak var priceImageView: UIImageView!
    
    @IBAction func goDetailPageButton(sender: AnyObject) {
        goDelegate?.goPage()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
