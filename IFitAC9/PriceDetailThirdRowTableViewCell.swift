//
//  PriceDetailThirdRowTableViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/20.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class PriceDetailThirdRowTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let screenSize = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        collectionView.registerNib(UINib(nibName: "PriceDetailThirdRowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/4, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = .Horizontal
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
       
        

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension PriceDetailThirdRowTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenHeight = UIScreen.mainScreen().bounds.height
        return CGSize(width: 150, height: screenHeight/4)
        
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PriceDetailThirdRowCollectionViewCell
        
        let screenHeight = UIScreen.mainScreen().bounds.height
        cell.cellViewHeight.constant = screenHeight/4
        
        
        
        
        
        return cell
    }
    
}

extension PriceDetailThirdRowTableViewCell: UITableViewDelegate {

}


