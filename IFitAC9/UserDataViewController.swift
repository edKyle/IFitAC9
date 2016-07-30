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
    var howManyTimes:[String] = []
    var weightLocalArray:[Double] = []
    var muscleLocalArray:[Double] = []
    var fatPercentLocalArray:[Double] = []
    var waterPercentLocalArray:[Double] = []
    var visceralFatLocalArray:[Double] = []
    var weightStander:String = ""
    var muscleStandar:String = ""
    var fatPercentStandar:String = ""
    var waterPercentStandar:String = ""
    var visceralFatStandar:String = ""
    
    var currentWeight:Double = 0
    var currentFat:Double = 0
    var currentMuscle:Double = 0
    var currentWater:Double = 0
    var currentVisceralFat:Double = 0
    var lastWeight:Double = 0
    var lastFat:Double = 0
    var lastMuscle:Double = 0
    var lastWater:Double = 0
    var lastVisceralFat:Double = 0
    
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
            titles: ["", "", "","",""],
            index: 0, backgroundColor: UIColor(red:1, green:1, blue:1, alpha:1),
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("topCell", forIndexPath: indexPath) as! UserDataTableViewCell
            
            switch control.index{
            case 0:
                if weightLocalArray.count == 0{
                    cell.topValueLabel.text = "\(0)Kg"
                }else{
                    cell.topValueLabel.text = "\(weightLocalArray[weightLocalArray.count-1])Kg"
                }
                cell.topCellLabel.text = "體重"
                cell.getHandPointX(self.weightStander)
                
            case 1:
                if fatPercentLocalArray.count == 0{
                    cell.topValueLabel.text = "\(0) %"
                }else{
                    cell.topValueLabel.text = "\(fatPercentLocalArray[fatPercentLocalArray.count-1]) %"
                }
                cell.topCellLabel.text = "體脂肪"
                cell.getHandPointX(self.fatPercentStandar)
                
            case 2:
                if muscleLocalArray.count == 0{
                    cell.topValueLabel.text = "\(0) %"
                }else{
                    cell.topValueLabel.text = "\(muscleLocalArray[muscleLocalArray.count-1]) %"
                }
                cell.topCellLabel.text = "肌肉量"
                cell.getHandPointX(self.muscleStandar)
                
            case 3:
                if waterPercentLocalArray.count == 0{
                    cell.topValueLabel.text = "\(0) %"
                }else{
                    cell.topValueLabel.text = "\(waterPercentLocalArray[waterPercentLocalArray.count-1]) %"
                }
                cell.topCellLabel.text = "含水量"
                cell.getHandPointX(self.waterPercentStandar)
            default:
                if visceralFatLocalArray.count == 0{
                    cell.topValueLabel.text = "\(0)"
                }else{
                    cell.topValueLabel.text = "\(visceralFatLocalArray[visceralFatLocalArray.count-1])"
                }
                cell.topCellLabel.text = "內臟脂肪"
                cell.getHandPointX(self.visceralFatStandar)
                           }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("downCell", forIndexPath: indexPath) as! UserDataTableViewCell2
            
            lastNowChangValue()
            
            switch control.index{
            case 0:
                cell.lasttimeValue.text = "\(lastWeight)"
                cell.nowValue.text = "\(currentWeight)"
                
                if lastWeight == 0{
                    cell.changValue.text = "0"
                }else{
                    cell.changValue.text = "\(lastWeight-currentWeight)"
                }
                
                cell.typeLabel.text = "kg"
                cell.typeLabel2.text = "kg"
                cell.typeLabel3.text = "kg"
                
                lineGraphView?.removeFromSuperview()
                makeLineView(self.weightLocalArray, times: howManyTimes)
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
                
            case 3:
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
                
            default:
                cell.lasttimeValue.text = "\(lastVisceralFat)"
                cell.nowValue.text = "\(currentVisceralFat)"
                
                if lastVisceralFat == 0{
                    cell.changValue.text = "0"
                }else{
                    cell.changValue.text = "\(lastVisceralFat-currentVisceralFat)"
                }
                
                cell.typeLabel.text = ""
                cell.typeLabel2.text = ""
                cell.typeLabel3.text = ""
                
                lineGraphView?.removeFromSuperview()
                makeLineView(self.visceralFatLocalArray, times: howManyTimes)
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
    @IBAction func visceralFatAction(sender: AnyObject) {
        do{
            try control.setIndex(4, animated: true)
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
                try control.setIndex(4, animated: true)
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
        if currentIndex == 4{
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
        //存weight
        for n in lineRecordData.recordData.weight{
           weightLocalArray.append(n)
        }
        if weightLocalArray.count > 6{
            for _ in 1...weightLocalArray.count - 6 {
                weightLocalArray.removeAtIndex(0)
            }
        }
        //存visceralFat
        for n in lineRecordData.recordData.visceralFat{
            visceralFatLocalArray.append(n)
        }
        if visceralFatLocalArray.count > 6{
            for _ in 1...visceralFatLocalArray.count - 6 {
                visceralFatLocalArray.removeAtIndex(0)
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
        //存date
        for n in lineRecordData.recordData.measuringDate{
            howManyTimes.append(n)
        }
        if howManyTimes.count > 6{
            for _ in 1...howManyTimes.count - 6{
                howManyTimes.removeAtIndex(0)
            }
        }
 
        
    }
    
    //判斷user各個標準值結果
    func toKnowUserStander(){
        if lineRecordData.recordData.weight != []{
            self.weightStander = makeData(weightLocalArray[weightLocalArray.count-1], MinData: Double(lineRecordData.recordData.userPerfectWeightMin)!, MaxData: Double(lineRecordData.recordData.userPerfectWeightMax)!)
        }
        if lineRecordData.recordData.musclePercent != []{
            self.muscleStandar = makeData(muscleLocalArray[muscleLocalArray.count-1], MinData: Double(lineRecordData.recordData.userPerfectMuscleMin)!, MaxData: Double(lineRecordData.recordData.userPerfectMuscleMax)!)
        }
        if lineRecordData.recordData.fatPercentage != []{
            self.fatPercentStandar = makeData(fatPercentLocalArray[fatPercentLocalArray.count-1], MinData: Double(lineRecordData.recordData.userPerfectFatMin)!, MaxData: Double(lineRecordData.recordData.userPerfectFatMax)!)
        }
        if lineRecordData.recordData.waterPercentage != []{
            self.waterPercentStandar = makeData(waterPercentLocalArray[waterPercentLocalArray.count-1], MinData: Double(lineRecordData.recordData.userPerfectWaterMin)!, MaxData: Double(lineRecordData.recordData.userPerfectWaterMax)!)
        }
        if lineRecordData.recordData.visceralFat != []{
            self.visceralFatStandar = makeData(visceralFatLocalArray[visceralFatLocalArray.count-1], MinData: Double(lineRecordData.recordData.userPerfectVisceralFatMin)!, MaxData: Double(lineRecordData.recordData.userPerfectVisceralFatMax)!)
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
    
    //算上次目前跟變化值
    func lastNowChangValue(){
        
        if weightLocalArray.count == 1 {
            currentWeight = weightLocalArray.last!
        }else if weightLocalArray.count > 1 {
            currentWeight = weightLocalArray.last!
            lastWeight = weightLocalArray[weightLocalArray.count-2]
        }
        
        if fatPercentLocalArray.count == 1 {
            currentFat = fatPercentLocalArray.last!
        }else if fatPercentLocalArray.count > 1 {
            currentFat = fatPercentLocalArray.last!
            lastFat = fatPercentLocalArray[fatPercentLocalArray.count-2]
        }

        if muscleLocalArray.count == 1 {
            currentMuscle = muscleLocalArray.last!
        }else if muscleLocalArray.count > 1 {
            currentMuscle = muscleLocalArray.last!
            lastMuscle = muscleLocalArray[muscleLocalArray.count-2]
        }

        if waterPercentLocalArray.count == 1 {
            currentWater = waterPercentLocalArray.last!
        }else if waterPercentLocalArray.count > 1 {
            currentWater = waterPercentLocalArray.last!
            lastWater = waterPercentLocalArray[waterPercentLocalArray.count-2]
        }
        if visceralFatLocalArray.count == 1 {
            currentVisceralFat = visceralFatLocalArray.last!
        }else if visceralFatLocalArray.count > 1 {
            currentVisceralFat = visceralFatLocalArray.last!
            lastVisceralFat = visceralFatLocalArray[visceralFatLocalArray.count-2]
        }

    }
    
}
