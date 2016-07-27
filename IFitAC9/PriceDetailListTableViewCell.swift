//
//  PriceDetailListTableViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/27.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class PriceDetailListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var priceImageView: UIImageView!
    @IBOutlet weak var getPriceButtonOutlet: UIButton!
    @IBOutlet weak var priceNameLable: UILabel!
    
    @IBOutlet weak var getPriceAction: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
