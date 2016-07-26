//
//  line4CollectionViewCell.swift
//  IFitAC9
//
//  Created by Kyle on 7/19/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class line4CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var reportButton4: UIButton!
    @IBOutlet weak var lineRecordView4: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lineRecordView4.layer.shadowColor = UIColor.blackColor().CGColor
        lineRecordView4.layer.shadowOpacity = 1
        lineRecordView4.layer.shadowOffset = CGSizeZero
        lineRecordView4.layer.shadowRadius = 10
    }
}
