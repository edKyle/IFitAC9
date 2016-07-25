//
//  ArticleTableViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/25.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleView: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var tltleLable: UILabel!
    @IBOutlet weak var indexLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        articleView.layer.shadowColor = UIColor.blackColor().CGColor
        articleView.layer.shadowOpacity = 1
        articleView.layer.shadowOffset = CGSizeZero
        articleView.layer.shadowRadius = 3

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
