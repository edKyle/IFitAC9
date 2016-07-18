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
    var height:Float?
    var weight:Float?
    var fatPercentage:Float?
    var waterPercentage:Float?
    var musclePercent:Float?
    var BMI:Float?
    var record = [user]
    
    func getUserInfo(user:CurrentUser){
        self.record.append(user)
    }
}
