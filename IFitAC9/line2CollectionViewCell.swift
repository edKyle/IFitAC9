//
//  line2CollectionViewCell.swift
//  IFitAC9
//
//  Created by Kyle on 7/19/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class line2CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lineRecordView2: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lineRecordView2.layer.shadowColor = UIColor.blackColor().CGColor
        lineRecordView2.layer.shadowOpacity = 1
        lineRecordView2.layer.shadowOffset = CGSizeZero
        lineRecordView2.layer.shadowRadius = 10

    }

}
