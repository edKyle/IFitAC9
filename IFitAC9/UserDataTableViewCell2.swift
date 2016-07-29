//
//  UserDataTableViewCell2.swift
//  IFitAC9
//
//  Created by Kyle on 7/24/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class UserDataTableViewCell2: UITableViewCell {

    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var typeLabel3: UILabel!
    @IBOutlet weak var typeLabel2: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var lasttimeValue: UILabel!
    @IBOutlet weak var changValue: UILabel!
    @IBOutlet weak var nowValue: UILabel!
    @IBOutlet weak var lineImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .None

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
