//
//  PriceViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/26.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class PriceViewController: UIViewController {

    @IBOutlet weak var priceUpperHalfCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var progressView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceUpperHalfCollectionView.dataSource = self
        priceUpperHalfCollectionView.delegate = self
        
        priceUpperHalfCollectionView.registerNib(UINib(nibName: "PriceViewCurrentPointCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Item1")
        
        priceUpperHalfCollectionView.registerNib(UINib(nibName: "NewPriceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Item2")
        
//        progressView.layer.shadowColor = UIColor.lightGrayColor().CGColor
//        progressView.layer.shadowOpacity = 1
//        progressView.layer.shadowOffset = CGSizeZero
//        progressView.layer.shadowRadius = 5
//        progressView.layer.shouldRasterize = true

        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
//            let progress = MBCircularProgressBarView()
            
            return item

        case 1:
            let item = priceUpperHalfCollectionView.dequeueReusableCellWithReuseIdentifier("Item2", forIndexPath: indexPath) as!
            NewPriceCollectionViewCell
            
            
            return item

        default:
            let item = priceUpperHalfCollectionView.dequeueReusableCellWithReuseIdentifier("Item2", forIndexPath: indexPath) as!
            NewPriceCollectionViewCell
            
            item.priceImageView.image = UIImage(named: "Post")
            item.priceDetailLable.text = "最新取得的鼓勵海報"
            
            return item
            
        }
    }
    
}