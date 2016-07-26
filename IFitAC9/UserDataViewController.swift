//
//  UserDataViewController.swift
//
//
//  Created by Kyle on 7/25/16.
//
//

import UIKit
import BetterSegmentedControl

class UserDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var lineGraphView:ScrollableGraphView?
    //data
    var howManyTimes:[String] = ["1","2","3","4","5","6"]
    var BMIlocalArray:[Double] = []
    var muscleLocalArray:[Double] = []
    var fatPercentLocalArray:[Double] = []
    var waterPercentLocalArray:[Double] = []
    var BMIStander:String = ""
    var muscleStander:String = ""
    var fatPercentStander:String = ""
    var waterPercentStander:String = ""
    
    
    //tableView
    @IBOutlet weak var ButtonView: UIView!
    @IBOutlet weak var UserDataTableView: UITableView!
    
    var control = BetterSegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //segamentControl
        let navHeight = navigationController?.navigationBar.frame.height
        let viewHeight = ButtonView.frame.height
        
        control = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: navHeight!+viewHeight+20, width: view.bounds.width, height: 5.0),
            titles: ["", "", "",""],
            index: 1, backgroundColor: UIColor(red:1, green:1, blue:1, alpha:1),
            titleColor: .blackColor(),
            indicatorViewBackgroundColor: UIColor(red:1, green:133/255, blue:133/255, alpha:1.00),
            selectedTitleColor: .blackColor())
        control.titleFont = UIFont(name: "HelveticaNeue", size: 14.0)!
        control.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0)!
        control.indicatorViewInset = -5
        control.addTarget(self, action: #selector(UserDataViewController.navigationSegmentedControlValueChanged(_:)), forControlEvents: .ValueChanged)
        
        view.addSubview(control)
        
        //tableView
        self.UserDataTableView.delegate = self
        self.UserDataTableView.dataSource = self
        
        let nibName = UINib(nibName: "UserDataTableViewCell", bundle: nil)
        UserDataTableView.registerNib(nibName, forCellReuseIdentifier: "topCell")
        
        let nibName2 = UINib(nibName: "UserDataTableViewCell2", bundle: nil)
        UserDataTableView.registerNib(nibName2, forCellReuseIdentifier: "downCell")
        
        UserDataTableView.estimatedRowHeight = 80
        UserDataTableView.rowHeight = UITableViewAutomaticDimension
        
        //data
        takeEveryDataToLocalArray()
        toKnowUserStander()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.layer.masksToBounds = false
        
        cell.layer.backgroundColor = UIColor.clearColor().CGColor
        cell.layer.shadowColor = UIColor.init(red: 99/255, green: 63/255, blue: 30/255, alpha: 1).CGColor

        cell.layer.shadowOffset = CGSizeMake(1, 1)
        cell.layer.shadowRadius = 1
        cell.layer.shadowOpacity = 1
       
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("topCell", forIndexPath: indexPath) as! UserDataTableViewCell
            
//            cell.layer.shadowOffset = CGSizeMake(1, 1)
//            cell.layer.shadowColor = UIColor.init(red: 99/255, green: 63/255, blue: 30/255, alpha: 1).CGColor
//            cell.layer.shadowRadius = 1
//            cell.layer.shadowOpacity = 1
            
            toKnowUserStander()
            
            switch control.index{
            case 0:
                if BMIlocalArray.count == 0{
                    cell.topValueLabel.text = "\(0)Kg"
                }else{
                    cell.topValueLabel.text = "\(BMIlocalArray[BMIlocalArray.count-1])Kg"
                }
                cell.topCellLabel.text = "體重"
                cell.getHandPointX(self.BMIStander)
                
            case 1:
                if fatPercentLocalArray.count == 0{
                    cell.topValueLabel.text = "\(0) %"
                }else{
                    cell.topValueLabel.text = "\(fatPercentLocalArray[fatPercentLocalArray.count-1]) %"
                }
                cell.topCellLabel.text = "體脂肪"
                cell.getHandPointX(self.fatPercentStander)
                
            case 2:
                if muscleLocalArray.count == 0{
                    cell.topValueLabel.text = "\(0) %"
                }else{
                    cell.topValueLabel.text = "\(muscleLocalArray[muscleLocalArray.count-1]) %"
                }
                cell.topCellLabel.text = "肌肉量"
                cell.getHandPointX(self.muscleStander)
                
            default:
                if waterPercentLocalArray.count == 0{
                    cell.topValueLabel.text = "\(0) %"
                }else{
                     cell.topValueLabel.text = "\(waterPercentLocalArray[waterPercentLocalArray.count-1]) %"
                }
                cell.topCellLabel.text = "含水量"
                cell.getHandPointX(self.waterPercentStander)
            }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("downCell", forIndexPath: indexPath) as! UserDataTableViewCell2
            
            var currentBMI:Double
            var currentFat:Double
            var currentMuscle:Double
            let currentWater:Double
            
            var lastBMI:Double
            var lastFat:Double
            var lastMuscle:Double
            let lastWater:Double
            
            if BMIlocalArray.count == 0 {
                currentBMI = 0
                lastBMI = 0
            }else if BMIlocalArray.count == 1{
                currentBMI = BMIlocalArray[BMIlocalArray.count-1]
                lastBMI = 0
            }else{
                currentBMI = BMIlocalArray[BMIlocalArray.count-1]
                lastBMI = BMIlocalArray[BMIlocalArray.count-2]
            }
            if fatPercentLocalArray.count == 0 {
                currentFat = 0
                lastFat = 0
            }else if fatPercentLocalArray.count == 1{
                currentFat = fatPercentLocalArray[fatPercentLocalArray.count-1]
                lastFat = 0
            }else{
                currentFat = fatPercentLocalArray[fatPercentLocalArray.count-1]
                lastFat = fatPercentLocalArray[fatPercentLocalArray.count-2]
            }
            
            if muscleLocalArray.count == 0 {
                currentMuscle = 0
                lastMuscle = 0
            }else if muscleLocalArray.count == 1{
                currentMuscle = muscleLocalArray[muscleLocalArray.count-1]
                lastMuscle = 0
            }else{
                currentMuscle = muscleLocalArray[muscleLocalArray.count-1]
                lastMuscle = muscleLocalArray[muscleLocalArray.count-2]
            }
            
            if waterPercentLocalArray.count == 0 {
                currentWater = 0
                lastWater = 0
            }else if waterPercentLocalArray.count == 1{
                currentWater = waterPercentLocalArray[waterPercentLocalArray.count-1]
                lastWater = 0
            }else{
                currentWater = waterPercentLocalArray[waterPercentLocalArray.count-1]
                lastWater = waterPercentLocalArray[waterPercentLocalArray.count-2]
            }
            
            switch control.index{
            case 0:
                cell.lasttimeValue.text = "\(lastBMI)"
                cell.nowValue.text = "\(currentBMI)"
                
                if lastBMI == 0{
                    cell.changValue.text = "0"
                }else{
                    cell.changValue.text = "\(lastBMI-currentBMI)"
                }
                
                cell.typeLabel.text = "kg"
                cell.typeLabel2.text = "kg"
                cell.typeLabel3.text = "kg"
                
                lineGraphView?.removeFromSuperview()
                makeLineView(self.BMIlocalArray, times: howManyTimes)
                cell.lineImageView.addSubview(lineGraphView!)
                
                
            case 1:
                cell.lasttimeValue.text = "\(lastFat)"
                cell.nowValue.text = "\(currentFat)"
                
                if lastFat == 0{
                    cell.changValue.text = "0"
                }else{
                    cell.changValue.text = "\(lastFat-currentFat)"
                }
                
                cell.typeLabel.text = "%"
                cell.typeLabel2.text = "%"
                cell.typeLabel3.text = "%"
                
                lineGraphView?.removeFromSuperview()
                makeLineView(self.fatPercentLocalArray, times: howManyTimes)
                cell.lineImageView.addSubview(lineGraphView!)
                
                
            case 2:
                cell.lasttimeValue.text = "\(lastMuscle)"
                cell.nowValue.text = "\(currentMuscle)"
               
                if lastMuscle == 0{
                    cell.changValue.text = "0"
                }else{
                    cell.changValue.text = "\(lastMuscle-currentMuscle)"
                }

                cell.typeLabel.text = "%"
                cell.typeLabel2.text = "%"
                cell.typeLabel3.text = "%"
                
                lineGraphView?.removeFromSuperview()
                makeLineView(self.muscleLocalArray, times: howManyTimes)
                cell.lineImageView.addSubview(lineGraphView!)
                
                
            default:
                cell.lasttimeValue.text = "\(lastWater)"
                cell.nowValue.text = "\(currentWater)"
                
                if lastWater == 0{
                    cell.changValue.text = "0"
                }else{
                    cell.changValue.text = "\(lastWater-currentWater)"
                }

                cell.typeLabel.text = "%"
                cell.typeLabel2.text = "%"
                cell.typeLabel3.text = "%"
                
                lineGraphView?.removeFromSuperview()
                makeLineView(self.waterPercentLocalArray, times: howManyTimes)
                cell.lineImageView.addSubview(lineGraphView!)
            }
            return cell
        }
        
        
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    //segamentControl
    @IBAction func waterAction(sender: AnyObject) {
        do{
            try control.setIndex(3, animated: true)
        }catch{
            print(error)
        }
    }
    @IBAction func muscleAction(sender: AnyObject) {
        do{
            try control.setIndex(2, animated: true)
        }catch{
            print(error)
        }
    }
    @IBAction func fatActin(sender: AnyObject) {
        do{
            try control.setIndex(1, animated: true)
        }catch{
            print(error)
        }
    }
    @IBAction func weightAction(sender: AnyObject) {
        do{
            try control.setIndex(0, animated: true)
        }catch{
            print(error)
        }
    }
    @IBAction func swipeRight(sender: AnyObject) {
        let currentIndex = control.index
        if currentIndex == 0{
            do{
                try control.setIndex(3, animated: true)
            }catch{
                
            }
        }else{
            do{
                try control.setIndex(currentIndex - 1, animated: true)
            }catch{
                
            }
        }
    }
    @IBAction func swipeLeft(sender: AnyObject) {
        let currentIndex = control.index
        if currentIndex == 3{
            do{
                try control.setIndex(0, animated: true)
            }catch{
            }
        }else{
            do{
                try control.setIndex(currentIndex + 1, animated: true)
            }catch{
                
            }
        }
    }
    func navigationSegmentedControlValueChanged(sender: BetterSegmentedControl) {
        self.UserDataTableView.reloadData()
    }
    
    
    // func 生成要劃的線
    func makeLineView(data:[Double], times:[String]){
        lineGraphView = nil
        lineGraphView = ScrollableGraphView(frame: CGRect(x: 20, y: 100, width: 300, height: 200))
        
        lineGraphView!.dataPointType = .Circle
        
        lineGraphView!.referenceLineLabelColor = UIColor.brownColor()
        lineGraphView!.referenceLineColor = UIColor.clearColor()
        lineGraphView!.numberOfIntermediateReferenceLines = 4
        
        lineGraphView!.backgroundFillColor = UIColor.clearColor()
        lineGraphView!.lineColor = UIColor.init(red: 255/255, green: 153/255, blue: 153/255, alpha: 1)
        
        lineGraphView!.dataPointLabelColor = UIColor.brownColor()
        lineGraphView!.dataPointFillColor = UIColor.init(red: 255/255, green: 153/255, blue: 153/255, alpha: 1)
        
        lineGraphView?.setData(data, withLabels: times)
    }
    
    //func 從model挖資料倒local controller
    func takeEveryDataToLocalArray(){
        //存BMI
        for n in lineRecordData.recordData.BMI{
            BMIlocalArray.append(n)
        }
        if BMIlocalArray.count > 6{
            for _ in 1...BMIlocalArray.count - 6 {
                BMIlocalArray.removeAtIndex(0)
            }
        }
        //存muscle
        for n in lineRecordData.recordData.musclePercent{
            muscleLocalArray.append(n)
        }
        if muscleLocalArray.count > 6{
            for _ in 1...muscleLocalArray.count - 6{
                muscleLocalArray.removeAtIndex(0)
            }
        }
        //存fat
        for n in lineRecordData.recordData.fatPercentage{
            fatPercentLocalArray.append(n)
        }
        if fatPercentLocalArray.count > 6{
            for _ in 1...fatPercentLocalArray.count - 6{
                fatPercentLocalArray.removeAtIndex(0)
            }
        }
        //存water
        for n in lineRecordData.recordData.waterPercentage{
            waterPercentLocalArray.append(n)
        }
        if waterPercentLocalArray.count > 6{
            for _ in 1...waterPercentLocalArray.count - 6{
                waterPercentLocalArray.removeAtIndex(0)
            }
        }
    }
    
    //判斷user各個標準值結果
    func toKnowUserStander(){
        if lineRecordData.recordData.BMI != []{
            self.BMIStander = makeData(BMIlocalArray[BMIlocalArray.count-1], MinData: Double(lineRecordData.recordData.userPerfectBMIMin)!, MaxData: Double(lineRecordData.recordData.userPerfectBMIMax)!)
        }
        if lineRecordData.recordData.musclePercent != []{
            self.muscleStander = makeData(muscleLocalArray[muscleLocalArray.count-1], MinData: Double(lineRecordData.recordData.userPerfectMuscleMin)!, MaxData: Double(lineRecordData.recordData.userPerfectMuscleMax)!)
        }
        if lineRecordData.recordData.fatPercentage != []{
            self.fatPercentStander = makeData(fatPercentLocalArray[fatPercentLocalArray.count-1], MinData: Double(lineRecordData.recordData.userPerfectFatMin)!, MaxData: Double(lineRecordData.recordData.userPerfectFatMax)!)
        }
        if lineRecordData.recordData.waterPercentage != []{
            self.waterPercentStander = makeData(waterPercentLocalArray[waterPercentLocalArray.count-1], MinData: Double(lineRecordData.recordData.userPerfectWaterMin)!, MaxData: Double(lineRecordData.recordData.userPerfectWaterMax)!)
        }
    }
    //判斷user各個標準值結果(標準值輔助計算公式)
    func makeData(data:Double,MinData:Double,MaxData:Double)->String{
        if data > MinData && data < MaxData{
            return "標準"
        }else if data < MinData{
            return "過低"
        }else if data > MaxData{
            return "過高"
        }
        return ""
    }
    
    
    
}