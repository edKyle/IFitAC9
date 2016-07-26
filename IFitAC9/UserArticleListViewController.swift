//
//  UserArticleListViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/25.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class UserArticleListViewController: UIViewController {

    var control = BetterSegmentedControl()
    var currentIndex:UInt = 0
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UserArticleListViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = articleTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ArticleTableViewCell
        
        cell.selectionStyle = .None
        
        if indexPath.row == 1{
            cell.articleImage.image = UIImage(named: "articleImage2")
        }
        
        return cell
    }
    
    
    
    
    
    
}
