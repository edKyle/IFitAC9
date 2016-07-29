//
//  SettingForQRCodeTableViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/29.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class SettingForQRCodeTableViewCell: UITableViewCell {

    @IBOutlet weak var qRCodeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        qRCodeImageView.image = CurrentUser.user.getUserQRCode()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func generateQRCodeFromString(string: String) -> UIImage? {
        let data = string.dataUsingEncoding(NSISOLatin1StringEncoding)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel")
            let transform = CGAffineTransformMakeScale(10, 10)
            
            if let output = filter.outputImage?.imageByApplyingTransform(transform) {
                return UIImage(CIImage: output)
            }
        }
        
        return nil
    }

    
}
