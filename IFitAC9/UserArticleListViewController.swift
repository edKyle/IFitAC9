//
//  UserArticleListViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/25.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import BetterSegmentedControl
import Alamofire
import SwiftyJSON
import WebKit
import SDWebImage


class UserArticleListViewController: UIViewController {

    var control = BetterSegmentedControl()
    var currentIndex:UInt = 0
    var articleArr = [AnyObject]()
    
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var buttonView: UIView!
    
    @IBAction func leftSwipe(sender: AnyObject) {
        let currentIndex = control.index
        if currentIndex == 2{
            do{
                try control.setIndex(0, animated: true)
            }catch{
                
            }
        }else{
            do{
                try control.setIndex(currentIndex + 1, animated: true)
            }catch{
                
            }
        }
    }
    
    @IBAction func rightSwipe(sender: AnyObject) {
        let currentIndex = control.index
        if currentIndex == 0{
            do{
                try control.setIndex(2, animated: true)
            }catch{
                
            }
        }else{
            do{
                try control.setIndex(currentIndex - 1, animated: true)
            }catch{
                
            }
        }
    }

    @IBAction func eatingButton(sender: AnyObject) {
        do{
            try control.setIndex(0, animated: true)
        }catch{
            
        }
    }
    
    @IBAction func exerciseButton(sender: AnyObject) {
        do{
            try control.setIndex(1, animated: true)
        }catch{
            
        }
    }
    
    @IBAction func personalButton(sender: AnyObject) {
        do{
            try control.setIndex(2, animated: true)
        }catch{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getArticle()
        
        let navHeight = navigationController?.navigationBar.frame.height
        let viewHeight = buttonView.frame.height
        
        control = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: navHeight!+viewHeight+20, width: view.bounds.width, height: 5.0),
            titles: ["", "", ""],
            index: 1, backgroundColor: UIColor(red:1, green:1, blue:1, alpha:1),
            titleColor: .blackColor(),
            indicatorViewBackgroundColor: UIColor(red:1, green:133/255, blue:133/255, alpha:1.00),
            selectedTitleColor: .blackColor())
        control.titleFont = UIFont(name: "HelveticaNeue", size: 14.0)!
        control.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0)!
        control.indicatorViewInset = -5
        control.addTarget(self, action: #selector(UserArticleListViewController.navigationSegmentedControlValueChanged(_:)), forControlEvents: .ValueChanged)
        
        do{
            try control.setIndex(currentIndex, animated: true)
        }catch{
            
        }
        
        view.addSubview(control)
        
        self.navigationItem.title = "你的個人指南"
        
        articleTableView.dataSource = self
        articleTableView.delegate = self
        
        articleTableView.registerNib(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        articleTableView.rowHeight = UITableViewAutomaticDimension
        articleTableView.estimatedRowHeight = 1000
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getArticle(){
        Alamofire.request(.GET, "http://alpha.i-fit.com.tw/api/v1/posts/index", parameters: nil)
            .responseJSON { response in
                
                if let JSON = response.result.value {
                    let json = JSON["data"] as! NSArray
                    self.articleArr = json as [AnyObject]
                    print(self.articleArr)
                    self.articleTableView.reloadData()
                }
        }
    }

    func navigationSegmentedControlValueChanged(sender: BetterSegmentedControl) {
        if sender.index == 0 {
            print("Turning lights on.")
            view.backgroundColor = .whiteColor()
        }
        else {
            print("Turning lights off.")
            view.backgroundColor = .darkGrayColor()
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWeb"{
            let desVc = segue.destinationViewController as! DetailWebViewController
            let articleSelect = articleArr[sender as! Int]
            desVc.urlStr = articleSelect["url"]! as? String
        }
    
    
    }
  

}

extension UserArticleListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showWeb", sender: indexPath.row)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articleArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = articleTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticleTableViewCell
        
        cell.selectionStyle = .None
        let article = articleArr[indexPath.row]
    
        cell.articleImage.sd_setImageWithURL(NSURL(string: article["logo"] as! String))
        cell.tltleLable.text = article["title"] as? String
        
        
        return cell
    }
    
    
    
    
    
    
}
