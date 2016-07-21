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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dropImage
        dropImage.image = UIImage(named: "降落傘")
        dropImage.contentMode = .ScaleAspectFit
        self.dropImage.userInteractionEnabled = true
        self.view.addSubview(dropImage)

        
        lineRecordCollectionView.delegate = self
        lineRecordCollectionView.dataSource = self
        
        let layout = self.lineRecordCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - UIScreen.mainScreen().bounds.width/1.5)
        
        
        let nibName = UINib(nibName: "lineCollectionViewCell", bundle:nil)
        self.lineRecordCollectionView.registerNib(nibName, forCellWithReuseIdentifier: "Cell")
        
        let nibName2 = UINib(nibName: "line2CollectionViewCell", bundle:nil)
        self.lineRecordCollectionView.registerNib(nibName2, forCellWithReuseIdentifier: "Cell2")
        
        let nibName3 = UINib(nibName: "line3CollectionViewCell", bundle:nil)
        self.lineRecordCollectionView.registerNib(nibName3, forCellWithReuseIdentifier: "Cell3")
        
        let nibName4 = UINib(nibName: "line4CollectionViewCell", bundle:nil)
        self.lineRecordCollectionView.registerNib(nibName4, forCellWithReuseIdentifier: "Cell4")
        
        
        takeEveryDataToLocalArray()
        
    }
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1.5, animations: {
                self.dropImage.image = UIImage(named: "降落傘")
                self.dropImage.frame.origin.x = -30
                self.dropImage.frame.origin.y = UIScreen.mainScreen().bounds.height-115
            }) { (nil) in
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
            self.dropImage.image = UIImage(named: "睡覺貓")
            let point = self.beginTouch.locationInView(self.dropImage.superview)
            self.dropImage.center = point
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIView.animateWithDuration(1.5, animations: {
            if self.beginTouch.view == self.dropImage{
                self.dropImage.image = UIImage(named: "降落傘")
                self.dropImage.frame.origin.x = -30
                self.dropImage.frame.origin.y = UIScreen.mainScreen().bounds.height-115
//                self.dropImage.transform = CGAffineTransformRotate(self.dropImage.transform, CGFloat(M_PI_2))
            }}) { (nil) in
                self.dropImage.image = UIImage(named: "睡覺貓")
        }
    }
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        while motion == .MotionShake{
            self.dropImage.image = UIImage(named: "shock")
            self.dropImage.frame.origin.x = 100
            self.dropImage.frame.origin.y = 30
        }
    }
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
            self.dropImage.image = UIImage(named: "睡覺貓")
            UIView.animateWithDuration(1.5, animations: {
            self.dropImage.image = UIImage(named: "降落傘")
            self.dropImage.frame.origin.x = -30
            self.dropImage.frame.origin.y = UIScreen.mainScreen().bounds.height-115
        }) { (nil) in
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
            lineGraphView?.removeFromSuperview()
            
            let cell = lineRecordCollectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! lineCollectionViewCell
            
            //把 ImageViewArray 跟 PointArray 清空
            self.ImgageViewArray = []
            ScrollableGraphView.linePointArray = []
            
            //輸入新的Data產生新圖
            
            makeLineView()
            cell.lineRecordView.addSubview(lineGraphView!)
            
            //delay一下後加imageView上去
            let triggerTime = (Int64(NSEC_PER_SEC) * 1/100)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
                for image in self.ImgageViewArray{
                    self.lineGraphView?.addSubview(image)
                }
            })
            return cell
            
        case 1:
            lineGraphView2?.removeFromSuperview()
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell2", forIndexPath: indexPath) as! line2CollectionViewCell
            
            self.ImgageViewArray = []
            ScrollableGraphView.linePointArray = []
            
            makeLineView2()
            cell.lineRecordView2.addSubview(self.lineGraphView2!)
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1/100)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
                for image in self.ImgageViewArray{
                    self.lineGraphView2?.addSubview(image)
                }
            })
            return cell
            
            
        case 2:
            lineGraphView3?.removeFromSuperview()
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell3", forIndexPath: indexPath) as! line3CollectionViewCell
            
            self.ImgageViewArray = []
            ScrollableGraphView.linePointArray = []
            
            makeLineView3()
            cell.lineRecordView3.addSubview(lineGraphView3!)
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1/100)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
                for image in self.ImgageViewArray{
                    self.lineGraphView3?.addSubview(image)
                }
            })
            return cell
            
        default:
            lineGraphView4?.removeFromSuperview()
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell4", forIndexPath: indexPath) as! line4CollectionViewCell
            
            self.ImgageViewArray = []
            ScrollableGraphView.linePointArray = []
            
            makeLineView4()
            cell.lineRecordView4.addSubview(lineGraphView4!)
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1/100)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
                for image in self.ImgageViewArray{
                    self.lineGraphView4?.addSubview(image)
                }
            })
            return cell
        }
    }
    
    
    
    
    
    // func 生成要劃的線
    func makeLineView(){
        lineGraphView = nil
        lineGraphView = ScrollableGraphView(frame: CGRectMake ( UIScreen.mainScreen().bounds.width/15, UIScreen.mainScreen().bounds.width/5, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height/2.3))
        
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
        lineGraphView2 = ScrollableGraphView(frame: CGRectMake ( UIScreen.mainScreen().bounds.width/15, UIScreen.mainScreen().bounds.width/5, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height/2.3))
        
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
        lineGraphView3 = ScrollableGraphView(frame: CGRectMake ( UIScreen.mainScreen().bounds.width/15, UIScreen.mainScreen().bounds.width/5, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height/2.3))
        
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
        lineGraphView4 = ScrollableGraphView(frame: CGRectMake ( UIScreen.mainScreen().bounds.width/15, UIScreen.mainScreen().bounds.width/5, UIScreen.mainScreen().bounds.width , UIScreen.mainScreen().bounds.height/2.3))
        
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
    
}


