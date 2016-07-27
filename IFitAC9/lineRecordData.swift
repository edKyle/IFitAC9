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
    
    var userAdvice:[String] = []
    
    var heigh:[Double] = []
    
    var weight:[Double] = []
    var fatPercentage:[Double] = []
    var waterPercentage:[Double] = []
    var musclePercent:[Double] = []
   
    
    var userPerfectWeightMin = "0"
    var userPerfectWeightMax = "0"
    
    var userPerfectMuscleMin = "0"
    var userPerfectMuscleMax = "0"
    
    var userPerfectFatMin = "0"
    var userPerfectFatMax = "0"
    
    var userPerfectWaterMin = "0"
    var userPerfectWaterMax = "0"
}
