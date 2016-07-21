//
//  ViewController.swift
//  lineTry
//
//  Created by Kyle on 7/12/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit
import AVFoundation

class UserViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    // 手的指標、標準值title、%Label
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var standerSegControll: UISegmentedControl!
    let pointImageView = UIImageView(frame: CGRect(x: 0, y: 130, width: 80, height: 80))
    
    //dropImage
    @IBOutlet weak var theViewUnderDropView: UIView!
    var beginTouch = UITouch()
    let dropImage = UIImageView(frame: CGRect(x:150, y: 0, width: 100, height: 100))
    
    //collectionView
    @IBOutlet weak var lineRecordCollectionView: UICollectionView!
    
    var ImgageViewArray:[UIImageView] = []
    
    var lineGraphView:ScrollableGraphView?
    var lineGraphView2:ScrollableGraphView?
    var lineGraphView3:ScrollableGraphView?
    var lineGraphView4:ScrollableGraphView?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = UIColor.init(red: 255/255, green: 230/255, blue: 207/255, alpha: 1)
        
        UITabBar.appearance().selectionIndicatorImage = UIImage(named: "dot")
        
        //指標
        pointImageView.image = UIImage(named: "指標")
        self.topView.addSubview(pointImageView)
        //dropImage
        dropImage.image = UIImage(named: "降落傘")
        dropImage.contentMode = .ScaleAspectFit
        self.dropImage.userInteractionEnabled = true
        self.view.addSubview(dropImage)
        
        lineRecordCollectionView.delegate = self
        lineRecordCollectionView.dataSource = self
        
        let layout = self.lineRecordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - UIScreen.mainScreen().bounds.width+10)
        
        
        let nibName = UINib(nibName: "lineCollectionViewCell", bundle:nil)
        self.lineRecordCollectionView.registerNib(nibName, forCellWithReuseIdentifier: "Cell")
        
        let nibName2 = UINib(nibName: "line2CollectionViewCell", bundle:nil)
        self.lineRecordCollectionView.registerNib(nibName2, forCellWithReuseIdentifier: "Cell2")
        
        let nibName3 = UINib(nibName: "line3CollectionViewCell", bundle:nil)
        self.lineRecordCollectionView.registerNib(nibName3, forCellWithReuseIdentifier: "Cell3")
        
        let nibName4 = UINib(nibName: "line4CollectionViewCell", bundle:nil)
        self.lineRecordCollectionView.registerNib(nibName4, forCellWithReuseIdentifier: "Cell4")
        
        
        takeEveryDataToLocalArray()
        toKnowUserStander()
        
    }
    override func viewDidAppear(animated: Bool) {
        self.dropImage.frame.origin.x = 150
        self.dropImage.frame.origin.y = 0
        UIView.animateWithDuration(1.8, animations: {
            self.dropImage.frame.size = CGSize(width: 150, height: 150)
            self.dropImage.image = UIImage(named: "降落傘")
            self.dropImage.frame.origin.x = -30
            self.dropImage.frame.origin.y = UIScreen.mainScreen().bounds.height-115
        }) { (nil) in
            self.dropImage.frame.size = CGSize(width: 100, height: 100)
            self.dropImage.image = UIImage(named: "睡覺貓")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.beginTouch = touches.first!
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if beginTouch.view == self.dropImage{
            self.dropImage.image = UIImage(named: "抓起")
            self.dropImage.frame.size = CGSize(width: 150, height: 150)
            let point = self.beginTouch.locationInView(self.dropImage.superview)
            self.dropImage.center = point
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.dropImage.frame.size = CGSize(width: 100, height: 100)
        UIView.animateWithDuration(1.8, animations: {
            if self.beginTouch.view == self.dropImage{
                self.dropImage.frame.size = CGSize(width: 150, height: 150)
                self.dropImage.image = UIImage(named: "降落傘")
                self.dropImage.frame.origin.x = -30
                self.dropImage.frame.origin.y = UIScreen.mainScreen().bounds.height-115
                
            }}) { (nil) in
                self.dropImage.frame.size = CGSize(width: 100, height: 100)
                self.dropImage.image = UIImage(named: "睡覺貓")
        }
    }
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake{
            self.dropImage.image = UIImage(named: "shock")
            self.dropImage.frame.origin.x = 100
            self.dropImage.frame.origin.y = 30
        }
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        UIView.animateWithDuration(1.5, animations: {
            self.dropImage.frame.origin.y = UIScreen.mainScreen().bounds.height-115
        }) { (nil) in
            self.dropImage.frame.size = CGSize(width: 100, height: 100)
            self.dropImage.image = UIImage(named: "睡覺貓")
        }
        
    }
    
    
    //collectionView
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.item{
        case 0:
            percentLabel.text = "\(BMIlocalArray[BMIlocalArray.count-1])%"
            
            getHandPointX(BMIStander)
            
            let cell1 = lineRecordCollectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! lineCollectionViewCell
            
            print(cell1)
            lineGraphView?.removeFromSuperview()
            
            //把 ImageViewArray 跟 PointArray 清空
            self.ImgageViewArray = []
            ScrollableGraphView.linePointArray = []
            
            //輸入新的Data產生新圖
            
            makeLineView()
            cell1.lineRecordView.addSubview(lineGraphView!)
            
            //delay一下後加imageView上去
            let triggerTime = (Int64(NSEC_PER_SEC) * 1/100)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
                for image in self.ImgageViewArray{
                    self.lineGraphView?.addSubview(image)
                }
            })
            return cell1
            
        case 1:
            percentLabel.text = "\(muscleLocalArray[muscleLocalArray.count-1])%"
            
            getHandPointX(muscleStander)
            
            let cell2 = collectionView.dequeueReusableCellWithReuseIdentifier("Cell2", forIndexPath: indexPath) as! line2CollectionViewCell
            
            
            lineGraphView2?.removeFromSuperview()
            
            self.ImgageViewArray = []
            ScrollableGraphView.linePointArray = []
            
            makeLineView2()
            cell2.lineRecordView2.addSubview(self.lineGraphView2!)
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1/100)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
                for image in self.ImgageViewArray{
                    self.lineGraphView2?.addSubview(image)
                }
            })
            return cell2
            
            
        case 2:
            percentLabel.text = "\(fatPercentLocalArray[fatPercentLocalArray.count-1])%"
            
            getHandPointX(fatPercentStander)
            
            let cell3 = collectionView.dequeueReusableCellWithReuseIdentifier("Cell3", forIndexPath: indexPath) as! line3CollectionViewCell
            
            lineGraphView3?.removeFromSuperview()
            
            self.ImgageViewArray = []
            ScrollableGraphView.linePointArray = []
            
            makeLineView3()
            cell3.lineRecordView3.addSubview(lineGraphView3!)
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1/100)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
                for image in self.ImgageViewArray{
                    self.lineGraphView3?.addSubview(image)
                }
            })
            return cell3
            
        default:
            percentLabel.text = "\(waterPercentLocalArray[waterPercentLocalArray.count-1])%"
            
            getHandPointX(waterPercentStander)
            
            let cell4 = collectionView.dequeueReusableCellWithReuseIdentifier("Cell4", forIndexPath: indexPath) as! line4CollectionViewCell
            
            lineGraphView4?.removeFromSuperview()
            
            self.ImgageViewArray = []
            ScrollableGraphView.linePointArray = []
            
            makeLineView4()
            cell4.lineRecordView4.addSubview(lineGraphView4!)
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1/100)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
                for image in self.ImgageViewArray{
                    self.lineGraphView4?.addSubview(image)
                }
            })
            return cell4
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageNum = CGFloat(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.standerSegControll.selectedSegmentIndex = Int(pageNum)
    }

    
    
    
    
    // func 生成要劃的線
    func makeLineView(){
        lineGraphView = nil
        lineGraphView = ScrollableGraphView(frame: CGRectMake ( UIScreen.mainScreen().bounds.width/18, UIScreen.mainScreen().bounds.width/15, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height/3+10))
        
        lineGraphView!.dataPointType = .Circle
        
        lineGraphView!.referenceLineLabelColor = UIColor.purpleColor()
        lineGraphView!.referenceLineColor = UIColor.clearColor()
        lineGraphView!.numberOfIntermediateReferenceLines = 4
        
        lineGraphView!.backgroundFillColor = UIColor.clearColor()
        lineGraphView!.lineColor = UIColor.purpleColor()
        lineGraphView!.dataPointLabelColor = UIColor.purpleColor()
        lineGraphView!.dataPointFillColor = UIColor.clearColor()
        lineGraphView?.setData(self.BMIlocalArray, withLabels: howManyTimes)
    }
    func makeLineView2(){
        lineGraphView2 = nil
        lineGraphView2 = ScrollableGraphView(frame: CGRectMake ( UIScreen.mainScreen().bounds.width/18, UIScreen.mainScreen().bounds.width/15, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height/3+10))
        
        lineGraphView2!.dataPointType = .Circle
        
        lineGraphView2!.referenceLineLabelColor = UIColor.purpleColor()
        lineGraphView2!.referenceLineColor = UIColor.clearColor()
        lineGraphView2!.numberOfIntermediateReferenceLines = 4
        
        lineGraphView2!.backgroundFillColor = UIColor.clearColor()
        lineGraphView2!.lineColor = UIColor.purpleColor()
        lineGraphView2!.dataPointLabelColor = UIColor.purpleColor()
        lineGraphView2!.dataPointFillColor = UIColor.clearColor()
        self.lineGraphView2?.setData(self.muscleLocalArray, withLabels: self.howManyTimes)
        
    }
    func makeLineView3(){
        lineGraphView3 = nil
        lineGraphView3 = ScrollableGraphView(frame: CGRectMake ( UIScreen.mainScreen().bounds.width/18, UIScreen.mainScreen().bounds.width/15, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height/3+10))
        
        lineGraphView3!.dataPointType = .Circle
        
        lineGraphView3!.referenceLineLabelColor = UIColor.purpleColor()
        lineGraphView3!.referenceLineColor = UIColor.clearColor()
        lineGraphView3!.numberOfIntermediateReferenceLines = 4
        
        lineGraphView3!.backgroundFillColor = UIColor.clearColor()
        lineGraphView3!.lineColor = UIColor.purpleColor()
        lineGraphView3!.dataPointLabelColor = UIColor.purpleColor()
        lineGraphView3!.dataPointFillColor = UIColor.clearColor()
        self.lineGraphView3?.setData(self.fatPercentLocalArray, withLabels: self.howManyTimes)
    }
    func makeLineView4(){
        lineGraphView4 = nil
        lineGraphView4 = ScrollableGraphView(frame: CGRectMake ( UIScreen.mainScreen().bounds.width/18, UIScreen.mainScreen().bounds.width/15, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height/3+10))
        
        lineGraphView4!.dataPointType = .Circle
        
        lineGraphView4!.referenceLineLabelColor = UIColor.purpleColor()
        lineGraphView4!.referenceLineColor = UIColor.clearColor()
        lineGraphView4!.numberOfIntermediateReferenceLines = 4
        
        lineGraphView4!.backgroundFillColor = UIColor.clearColor()
        lineGraphView4!.lineColor = UIColor.purpleColor()
        lineGraphView4!.dataPointLabelColor = UIColor.purpleColor()
        lineGraphView4!.dataPointFillColor = UIColor.clearColor()
        self.lineGraphView4?.setData(self.waterPercentLocalArray, withLabels: self.howManyTimes)
    }
    
    
    
    //func 生成要加的ImageView
    func makeLinePointImageView(){
        
        for point in ScrollableGraphView.linePointArray{
            
            let pictureView = UIImageView(frame:CGRect(x: point.x, y: 280, width: 50, height: 50))
            pictureView.image = UIImage(named: "linePointImage")
            
            UIView.animateWithDuration(2, animations: {
                
                pictureView.frame.origin.x = point.x - 25
                pictureView.frame.origin.y = point.y - 25
                
                self.ImgageViewArray.append(pictureView)
                
            })
            
        }
        
    }
    //func 指標x軸計算
    func getHandPointX(standerValue:String){
        if standerValue != ""{
            UIView.animateWithDuration(2, animations: {
                switch standerValue{
                case "過低":
                    self.pointImageView.frame.origin.x = 0
                case "標準":
                    self.pointImageView.frame.origin.x = UIScreen.mainScreen().bounds.width/2.7
                default:
                    self.pointImageView.frame.origin.x = UIScreen.mainScreen().bounds.width/3*2.2
                }
            })
        }
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
    @IBAction func standerSegControllAction(sender: AnyObject) {
        let x = UIScreen.mainScreen().bounds.width
        switch self.standerSegControll.selectedSegmentIndex{
        case 0:
            lineRecordCollectionView.setContentOffset(CGPointMake(0, 0), animated: true)
        case 1:
            lineRecordCollectionView.setContentOffset(CGPointMake(x, 0), animated: true)
        case 2:
            lineRecordCollectionView.setContentOffset(CGPointMake(x*2, 0), animated: true)
        default:
            lineRecordCollectionView.setContentOffset(CGPointMake(x*3, 0), animated: true)
        }
}
}

