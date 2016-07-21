//
//  lineCollectionViewCell.swift
//  IFitAC9
//
//  Created by Kyle on 7/19/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class lineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lineRecordView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lineRecordView.layer.shadowColor = UIColor.blackColor().CGColor
        lineRecordView.layer.shadowOpacity = 1
        lineRecordView.layer.shadowOffset = CGSizeZero
        lineRecordView.layer.shadowRadius = 10
        
    }
    
}
