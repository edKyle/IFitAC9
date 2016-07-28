//
//  PriceDetailListTableViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/27.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

protocol GoPriceDelegate:class {
    func canGo()
}

class PriceDetailListTableViewCell: UITableViewCell {

    weak var goPriceDelegate: GoPriceDelegate?
    var priceStatus = false
    
    @IBOutlet weak var priceImageView: UIImageView!
    @IBOutlet weak var getPriceButtonOutlet: UIButton!
    @IBOutlet weak var priceNameLable: UILabel!
    
    @IBAction func getPriceAction(sender: AnyObject) {
        goPriceDelegate?.canGo()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
