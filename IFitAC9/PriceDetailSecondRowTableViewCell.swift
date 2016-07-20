//
//  PriceDetailSecondRowTableViewCell.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/19.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class PriceDetailSecondRowTableViewCell: UITableViewCell {
    

    @IBOutlet weak var collectionViewOutlay: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let screenSize = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        collectionView.registerNib(UINib(nibName: "PriceDetailSecondRowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/4, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        layout.scrollDirection = .Horizontal
        
        
        collectionViewOutlay.minimumLineSpacing = 0
        collectionViewOutlay.minimumInteritemSpacing = 0
        collectionView.setCollectionViewLayout(collectionViewOutlay, animated: true)
        
        
        collectionView.dataSource = self
        collectionView.delegate = self

        
        // Do any additional setup after loading the view, typically from a nib
        }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension PriceDetailSecondRowTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PriceDetailSecondRowCollectionViewCell
        
        

        cell.cellViewHeight.constant = (UIScreen.mainScreen().bounds.height / 4) - 15
        print("View")
        print(cell.cellViewHeight.constant)
        print("compare")
        print(UIScreen.mainScreen().bounds.height / 4)
        
//        cell.bounds = CGRectMake(cell.frame.origin.x, 0, screen.width/3, screen.height/4)
        //        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, screen.width/3, screen.height/4)
        
        return cell
    }
    
}

