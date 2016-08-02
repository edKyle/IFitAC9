//
//  PriceMapViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/26.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class PriceMapViewController: UIViewController {
    
    var price = [AnyObject]()
    var isFirst:Bool?
    let userId:Int = CurrentUser.user.menberID!
    
    @IBOutlet weak var priceMapCollectionView: UICollectionView!
    @IBOutlet weak var runningGirl: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceMapCollectionView.registerNib(UINib(nibName: "PriceMapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Item")
        priceMapCollectionView.dataSource = self
        priceMapCollectionView.delegate = self
        
        Alamofire.request(.GET, "http://alpha.i-fit.com.tw/api/v1/products/index", parameters: [:])
            .responseJSON { response in
                if let JSON = response.result.value{
                    self.price = JSON["data"] as! NSArray as [AnyObject]
                    print(self.price)
                    self.sortArray(self.price)
                }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        isFirst = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sortArray(Array:[AnyObject]){
        if Array.count > 2{
            
            var ansArray = [AnyObject]()
            for _ in 0...Array.count - 1{
                ansArray.append(["a":"b"])
            }
            var position = 0
            var i = 0
            var biggerThen = 0
            while  i < Array.count {
                for y in 0...Array.count-1{
                    if (price[i].objectForKey("required_points") as! Int) < (price[y].objectForKey("required_points") as! Int){
                        biggerThen += 1
                    }
                }
                position = price.count - biggerThen - 1
                ansArray[position] = price[i]
                i += 1
                position = 0
                biggerThen = 0
            }
            price = ansArray
            print(price)
            self.priceMapCollectionView.reloadData()
            var startItem = 0
            Alamofire.request(.GET, "http://alpha.i-fit.com.tw/api/v1/points", parameters: ["user_id": userId])
                .responseJSON { response in
                    
                    if let point = response.result.value{
                        let currentPoint = point["points"] as! Int
                        CurrentUser.user.currentPoint = currentPoint
                        let point = CurrentUser.user.currentPoint
                        for index in self.price{
                            let pricePoint = index.objectForKey("required_points") as! Int
                            if point < pricePoint{
                                
                            }else{
                                startItem += 1
                            }
                        }
                        
                        print(CurrentUser.user.currentPoint)
                        print(startItem)
                        self.priceMapCollectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: startItem, inSection: 0), atScrollPosition: .CenteredHorizontally, animated: true)
                    }
            }
            
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
    
}

extension PriceMapViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        if isFirst!{
            if let point = CurrentUser.user.currentPoint{
                let pricePoint = price[indexPath.item].objectForKey("required_points") as! Int
                if pricePoint > point{
                    let indexToScrollTo = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section)
                    self.priceMapCollectionView.scrollToItemAtIndexPath(indexToScrollTo, atScrollPosition: .Left, animated: false)
                }
            }
            isFirst = false
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.5, delay: 0, options: .AllowUserInteraction, animations: {
            Void in
            self.runningGirl.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/8))
            }, completion:{
                succeed in
                UIView.animateWithDuration(0.5, delay: 0, options: .BeginFromCurrentState, animations: {
                    Void in
                    self.runningGirl.transform = CGAffineTransformMakeRotation(CGFloat(0))
                    }, completion:{
                        succeed in
                })
        })
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = view.bounds.width
        return CGSizeMake(width, collectionView.bounds.height)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return price.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = priceMapCollectionView.dequeueReusableCellWithReuseIdentifier("Item", forIndexPath: indexPath) as! PriceMapCollectionViewCell
        item.goPageDelegate = self
        let point =  price[indexPath.item].objectForKey("required_points") as? Int
        item.pointLable.text = "\(point!)點獎勵"
        item.imageTraillingContrant.constant = 25
        item.priceImageView.sd_setImageWithURL(NSURL(string: (price[indexPath.item].objectForKey("logo") as? String)!))
        
        return item
        
    }
    
    
    
}

extension PriceMapViewController: GoPageDelegate{
    
    func goPage(index: Int) {
        let storyboard = UIStoryboard.init(name: "AchievementStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("PriceListViewController") as! PriceListViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}