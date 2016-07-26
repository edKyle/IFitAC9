//
//  UserDetailViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/25.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var indexForArticle:UInt = 0
    
    @IBOutlet weak var userDetailHeaderView: UIView!

    @IBAction func eatButton(sender: AnyObject) {
//        indexForArticle = 0
////        self.performSegueWithIdentifier("showArticleSegue", sender: nil)
//        let storyboard = UIStoryboard.init(name: "AchievementStoryboard", bundle: nil)
//        let controller = storyboard.instantiateViewControllerWithIdentifier("UserArticleListViewController")
//        self.navigationController?.pushViewController(controller, animated: true)
        go(0)   
    }
    
    @IBAction func exerciseButton(sender: AnyObject) {
//        indexForArticle = 1
//        self.performSegueWithIdentifier("showArticleSegue", sender: nil)
        go(1)
    }
    
    @IBAction func personalGuideButton(sender: AnyObject) {
//        indexForArticle = 2
//        self.performSegueWithIdentifier("showArticleSegue", sender: nil)
        go(2)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        userDetailHeaderView.layer.shadowColor = UIColor.blackColor().CGColor
        userDetailHeaderView.layer.shadowOpacity = 1
        userDetailHeaderView.layer.shadowOffset = CGSizeZero
        userDetailHeaderView.layer.shadowRadius = 5
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showArticleSegue"{
//            let desVc = segue.destinationViewController as! UserArticleListViewController
//            desVc.currentIndex = indexForArticle
//        
//        }
//    
//    }
    func go(indexForArticle: UInt) {
        let storyboard = UIStoryboard.init(name: "AchievementStoryboard", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("UserArticleListViewController") as! UserArticleListViewController
        controller.currentIndex = indexForArticle
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    

}
