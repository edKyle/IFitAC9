//
//  ViewController.swift
//  lineTry
//
//  Created by Kyle on 7/12/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit

private let reuseIdentifier = "lineRecordCell"

class UserViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lineRecordCollectionLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var lineRecordCollectionView: UICollectionView!
    
    var lineGraphView:ScrollableGraphView?
    var howManyTimes:[String] = ["1","2","3","4","5","6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lineRecordCollectionView.delegate = self
        lineRecordCollectionView.dataSource = self
        
        lineRecordCollectionLayout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height - UIScreen.mainScreen().bounds.width/1.5)
        
        makeLineView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! lineRecordCollectionViewCell
        
        switch indexPath.item{
        case 0:
            lineGraphView?.setData(lineRecordData.recordData.BMI, withLabels: howManyTimes)
            cell.lineRecordView.addSubview(lineGraphView!)

            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
            })
            
        case 1:
            lineGraphView?.setData(lineRecordData.recordData.musclePercent, withLabels: howManyTimes)
            cell.lineRecordView.addSubview(lineGraphView!)
  
            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
            })

            
        case 2:
            lineGraphView?.setData(lineRecordData.recordData.fatPercentage, withLabels: howManyTimes)
            cell.lineRecordView.addSubview(lineGraphView!)
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
            })
            
        default:
            lineGraphView?.setData(lineRecordData.recordData.waterPercentage, withLabels: howManyTimes)
            cell.lineRecordView.addSubview(lineGraphView!)
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                self.makeLinePointImageView()
            })
            
        }
        return cell
    }
    
    
    
    
    
    func makeLineView(){
        lineGraphView = nil
        lineGraphView = ScrollableGraphView(frame: CGRectMake ( UIScreen.mainScreen().bounds.width/15, UIScreen.mainScreen().bounds.width/5, 300, 250))
        
        lineGraphView!.dataPointType = .Circle
        
        lineGraphView!.referenceLineLabelColor = UIColor.purpleColor()
        lineGraphView!.referenceLineColor = UIColor.clearColor()
        lineGraphView!.numberOfIntermediateReferenceLines = 4
        
        lineGraphView!.backgroundFillColor = UIColor.clearColor()
        lineGraphView!.lineColor = UIColor.purpleColor()
        lineGraphView!.dataPointLabelColor = UIColor.purpleColor()
        lineGraphView!.dataPointFillColor = UIColor.clearColor()
    }
    
    func makeLinePointImageView(){
        
        for point in ScrollableGraphView.linePointArray{
            
            let pictureView = UIImageView(frame:CGRect(x: point.x, y: 280, width: 50, height: 50))
            pictureView.image = UIImage(named: "皮蛋拿彩帶")
            
            UIView.animateWithDuration(2, animations: {
                
                pictureView.frame.origin.x = point.x - 25
                pictureView.frame.origin.y = point.y - 25
                
                print(pictureView.frame.origin.x)
                self.lineGraphView!.addSubview(pictureView)
            })
            
        }
    }
}



