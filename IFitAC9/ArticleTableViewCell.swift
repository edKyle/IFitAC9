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
        articleView.layer.shadowColor = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1).CGColor
        articleView.layer.shadowOpacity = 3
        articleView.layer.shadowOffset = CGSizeZero
        articleView.layer.shadowRadius = 3
        articleView.layer.shouldRasterize = true

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
