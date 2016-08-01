//
//  UseradviceTableViewCell.swift
//  IFitAC9
//
//  Created by Kyle on 8/1/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class UseradviceTableViewCell: UITableViewCell {

    @IBOutlet weak var adviceDay: UIButton!
    @IBOutlet weak var adviceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
