//
//  UserDetailViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/25.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import Alamofire

class UserDetailViewController: UIViewController {
    
    var indexForArticle:UInt = 0
    
    @IBOutlet weak var userDetailHeaderView: UIView!
    @IBOutlet weak var settingCoverView: UIView!
    @IBOutlet weak var nameLable: UILabel!
    

    @IBAction func goTestAction(sender: AnyObject) {
        let storyboard = UIStoryboard.init(name: "UserDetail", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("TestViewController") as! TestViewController
        controller.whereYouFrom = 1
            self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func settingAction(sender: AnyObject) {
        
        
        
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        NSURLCache.sharedURLCache().diskCapacity = 0
        NSURLCache.sharedURLCache().memoryCapacity = 0
        if let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies {
            for cookie in cookies {
                NSHTTPCookieStorage.sharedHTTPCookieStorage().deleteCookie(cookie)
            }
        }
    }
    
    
    @IBAction func eatButton(sender: AnyObject) {
        go(0)   
    }
    
    @IBAction func exerciseButton(sender: AnyObject) {
        go(1)
    }
    
    @IBAction func personalGuideButton(sender: AnyObject) {
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
        
        nameLable.text = CurrentUser.user.name
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func go(indexForArticle: UInt) {
        let storyboard = UIStoryboard.init(name: "UserDetail", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("UserArticleListViewController") as! UserArticleListViewController
        controller.currentIndex = indexForArticle
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
     

}
