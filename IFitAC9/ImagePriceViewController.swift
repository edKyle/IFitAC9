//
//  ImagePriceViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/28.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class ImagePriceViewController: UIViewController {

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "桌布列表"
        self.tabBarController?.tabBar.hidden = true
        
        imageCollectionView.registerNib(UINib(nibName: "ImagePriceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Item")
        
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
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

extension ImagePriceViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(161, 279)
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = imageCollectionView.dequeueReusableCellWithReuseIdentifier("Item", forIndexPath: indexPath) as! ImagePriceCollectionViewCell
        
        return item
    }
    
}