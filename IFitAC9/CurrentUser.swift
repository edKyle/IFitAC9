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
    var menberID:String?
    var name:String?
    var age:Int?
    var mPhoneNumber:String?
    var email:String?
    var token:String?
    
    var record:[CurrentUser] = []
    
    func getUserInfo(user:CurrentUser){
        self.record.append(user)
    }
}


