//
//  PriceViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/26.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import Alamofire

class PriceViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    let userId:Int = CurrentUser.user.menberID!

    @IBOutlet weak var priceScrollView: UIScrollView!
    @IBOutlet weak var priceUpperHalfCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var progressView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的獎勵"
        
        priceUpperHalfCollectionView.dataSource = self
        priceUpperHalfCollectionView.delegate = self
        
        priceUpperHalfCollectionView.registerNib(UINib(nibName: "PriceViewCurrentPointCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Item1")
        
        priceUpperHalfCollectionView.registerNib(UINib(nibName: "NewPriceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Item2")
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(PriceViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.priceUpperHalfCollectionView.alwaysBounceVertical = true
        priceScrollView.addSubview(refreshControl)
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

    }
    
    override func viewWillAppear(animated: Bool) {
        Alamofire.request(.GET, "http://alpha.i-fit.com.tw/api/v1/points", parameters: ["user_id": userId])
            .responseJSON { response in
                
                if let point = response.result.value{
                    let currentPoint = point["points"] as! Int
                    CurrentUser.user.currentPoint = currentPoint
                    self.priceUpperHalfCollectionView.reloadData()
                    
                }
        }

        priceUpperHalfCollectionView.reloadData()
    }
    override func viewDidAppear(animated: Bool) {
        priceUpperHalfCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh(sender:AnyObject) {
        
        print(userId)
        Alamofire.request(.GET, "http://alpha.i-fit.com.tw/api/v1/points", parameters: ["user_id": userId])
            .responseJSON { response in
                
                if let point = response.result.value{
                    let currentPoint = point["points"] as! Int
                    CurrentUser.user.currentPoint = currentPoint
                    self.priceUpperHalfCollectionView.reloadData()
                    self.refreshControl.endRefreshing()
                    
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

extension PriceViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        print("page = \(page)")
        
        self.pageControl.currentPage = page
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.mainScreen().bounds.width
        return CGSizeMake(width, collectionView.bounds.height)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let item = priceUpperHalfCollectionView.dequeueReusableCellWithReuseIdentifier("Item1", forIndexPath: indexPath) as! PriceViewCurrentPointCollectionViewCell
            item.progressBar.value = 1
            
            
            UIView.animateWithDuration(1, animations: {
                }, completion: {
                    succees in
                    if succees{
                        if let point = CurrentUser.user.currentPoint{
                            var target:CGFloat = 30
                            switch point {
                            case 0...19:
                                target = 20
                            case 19...39:
                                target = 40
                            default:
                                target = 55
                            }

                            print(point)
                            let pointHere = (CGFloat(point)/target*100)
                            let progress = round(pointHere)
                            print(progress)
                            item.progressBar.setValue(progress, animateWithDuration: 2)
                            item.targetLable.text = "/\(Int(target))"
                            item.currentPointLable.text = String(point)
                        }else{
                            item.progressBar.setValue(0, animateWithDuration: 2)
                        }
                    }
            })
            
            return item

        case 1:
            let item = priceUpperHalfCollectionView.dequeueReusableCellWithReuseIdentifier("Item2", forIndexPath: indexPath) as!
            NewPriceCollectionViewCell
            item.index = 1
            item.goDelegate = self
            
            
            return item

        default:
            let item = priceUpperHalfCollectionView.dequeueReusableCellWithReuseIdentifier("Item2", forIndexPath: indexPath) as!
            NewPriceCollectionViewCell
            
            item.index = 2
            item.priceImageView.image = UIImage(named: "Post")
            item.priceDetailLable.text = "最新取得的鼓勵海報"
            item.goDelegate = self
            
            return item
            
        }
    }
    
}

extension PriceViewController: GoPageDelegate{
    func goPage(index:Int) {
        if index == 1{
            self.performSegueWithIdentifier("showDetailsegue", sender: nil)
        }else if index == 2{
            self.performSegueWithIdentifier("showPostPriceSegeu", sender: nil)
        }
    }
    
}

