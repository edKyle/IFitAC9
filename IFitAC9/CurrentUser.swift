//
//  CurrentUser.swift
//  IFitAC9
//
//  Created by Kyle on 7/18/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class CurrentUser{
    static let user = CurrentUser()
    var menberID:Int?
    var name:String?
    var age:Int?
    var mPhoneNumber:String?
    var email:String?
    var token:String?
    var userType:Int?
    var currentPoint:Int?
    
    var record:[CurrentUser] = []
    
    func getUserInfo(user:CurrentUser){
        self.record.append(user)
    }
    
    func generateQRCodeFromString(string: String) -> UIImage? {
        let qrString = "email=" + string
        let data = qrString.dataUsingEncoding(NSISOLatin1StringEncoding)
        
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
    
    func getUserQRCode()->UIImage{
        return self.generateQRCodeFromString(self.email!)!
    }

}


