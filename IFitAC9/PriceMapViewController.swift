//
//  PriceMapViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/26.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class PriceMapViewController: UIViewController {

    @IBOutlet weak var priceMapCollectionView: UICollectionView!
    @IBOutlet weak var runningGirl: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceMapCollectionView.registerNib(UINib(nibName: "PriceMapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Item")
        priceMapCollectionView.dataSource = self
        priceMapCollectionView.delegate = self

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

extension PriceMapViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
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
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = priceMapCollectionView.dequeueReusableCellWithReuseIdentifier("Item", forIndexPath: indexPath) as! PriceMapCollectionViewCell
        item.goPageDelegate = self
        switch indexPath.item {
        case 0:
            
            
            item.pointLable.text = "30點獎勵"
            item.imageTraillingContrant.constant = 20
            item.priceImageView.image = UIImage(named: "priceNo1")
            
            return item
            
        case 1:
            
            item.imageTraillingContrant.constant = 15
            item.pointLable.text = "45點獎勵"
            item.priceImageView.image = UIImage(named: "priceNo2CupCake")
            
            return item
            
        default:
            
            item.priceImageView.image = UIImage(named: "priceNo1")
            item.imageTraillingContrant.constant = 20
            item.pointLable.text = "60點獎勵"
            
            return item
            
        }
    }
    
 
}

extension PriceMapViewController: GoPageDelegate{
    
    func goPage(index: Int) {
        let storyboard = UIStoryboard.init(name: "AchievementStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("PriceListViewController") as! PriceListViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}