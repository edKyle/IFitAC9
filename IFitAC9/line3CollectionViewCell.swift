//
//  line3CollectionViewCell.swift
//  IFitAC9
//
//  Created by Kyle on 7/19/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class line3CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reportButton3: UIButton!
    @IBOutlet weak var lineRecordView3: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lineRecordView3.layer.shadowColor = UIColor.blackColor().CGColor
        lineRecordView3.layer.shadowOpacity = 1
        lineRecordView3.layer.shadowOffset = CGSizeZero
        lineRecordView3.layer.shadowRadius = 10
    }

}
