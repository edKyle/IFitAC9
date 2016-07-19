//
//  TableViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/18.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class AchievementTableViewCell: UITableViewCell {

    @IBOutlet weak var roundProgress: MBCircularProgressBarView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
