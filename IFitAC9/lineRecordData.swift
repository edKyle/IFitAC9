//
//  lineRecordData.swift
//  IFitAC9
//
//  Created by Kyle on 7/19/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

class lineRecordData{
    
    static let recordData = lineRecordData()
    
    var heigh:[Double] = []
    var weight:[Double] = []
    var fatPercentage:[Double] = [70,50,22,49,50,10,39,20,90]
    var waterPercentage:[Double] = [45,67,43,23,44,69,89,33,34]
    var musclePercent:[Double] = [55,68,89,49,78,39,48,57,76]
    var BMI:[Double] = [80]
    
    var userPerfectBMIMin = "30"
    var userPerfectBMIMax = "70"
    
    var userPerfectMuscleMin = "50"
    var userPerfectMuscleMax = "80"
    
    var userPerfectFatMin = "30"
    var userPerfectFatMax = "50"
    
    var userPerfectWaterMin = "50"
    var userPerfectWaterMax = "90"
}
