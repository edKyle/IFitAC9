//
//  UserDataTableViewCell.swift
//  IFitAC9
//
//  Created by Kyle on 7/24/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class UserDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var topStanderImageView: UIImageView!
    @IBOutlet weak var topValueLabel: UILabel!
    @IBOutlet weak var topCellLabel: UILabel!
    @IBOutlet weak var tailImageView: UIImageView!
    
    let x = UIScreen.mainScreen().bounds.width/6
    
    @IBOutlet weak var nearCenterConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowOffset = CGSizeMake(1, 1)
        self.layer.shadowColor = UIColor.init(red: 99/255, green: 63/255, blue: 30/255, alpha: 1).CGColor
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 1
        self.layer.zPosition = 10

        
        self.tailImageView.transform = CGAffineTransformIdentity
        
        self.selectionStyle = .None
    
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //func 指標x軸計算
    func getHandPointX(standerValue:String){
        if standerValue != ""{
           
            UIView.animateWithDuration(2, animations: {
                
                switch standerValue{
                case "過低":
                    self.tailImageView.transform = CGAffineTransformMakeTranslation(-self.x, 0)
                case "標準":
                    self.tailImageView.transform = CGAffineTransformMakeTranslation(0, 0)
                default:
                    self.tailImageView.transform = CGAffineTransformMakeTranslation(self.x, 0)
                }
            })
        }
    }
}
