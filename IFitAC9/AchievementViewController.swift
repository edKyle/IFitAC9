//
//  AchievementViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/18.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class AchievementViewController: UIViewController {
    
    @IBOutlet weak var priceListTableView: UITableView!
    @IBOutlet weak var archievementListTableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var archievementList = ["至門市檢測一次", "體脂在標準值內","門市踩點（Center)", "門市踩點（else)", "第一次檢測", "第二次檢測", "第三次檢測", "BMI合乎標準", "體脂率合乎標準", "肌肉量合乎標準", "含水量合乎標準", "BMI下降", "BMI維持 IF 合格", "體脂率下降", "體脂率維持 IF 合格", "肌肉量上升", "肌肉量維持 IF 合格"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.title = "我的成就"
        
        priceListTableView.registerNib(UINib(nibName: "ArchievementListTableViewCell", bundle: nil), forCellReuseIdentifier: "CellForPrice")
//        tableView.registerNib(UINib(nibName: "AchievementTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        archievementListTableView.registerNib(UINib(nibName: "ArchievementListTableViewCell", bundle: nil), forCellReuseIdentifier: "CellForList")
        

        
        archievementListTableView.dataSource = self
        priceListTableView.dataSource = self
        archievementListTableView.delegate = self
        priceListTableView.delegate = self
        
        archievementListTableView.estimatedRowHeight = 200
        archievementListTableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
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

extension AchievementViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == archievementListTableView{
            
        }else{
             self.performSegueWithIdentifier("chooseCoinSegue", sender: nil)
//            performSegueWithIdentifier("priceDetailSegue", sender: nil)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:indexPath)
        let cellForList = archievementListTableView.dequeueReusableCellWithIdentifier("CellForList", forIndexPath: indexPath) as! ArchievementListTableViewCell
        
        let cellForPrice = priceListTableView.dequeueReusableCellWithIdentifier("CellForPrice", forIndexPath: indexPath) as! ArchievementListTableViewCell
        
        cellForPrice.accessoryType = .Checkmark
        
        
        cellForList.accessoryType = .None
        
        cellForList.accessoryType = .Checkmark
        cellForList.archievementListLable.text = archievementList[indexPath.row]
        if tableView == self.archievementListTableView{
            return cellForList
        }else{
            return cellForPrice
        }
    }
    
}