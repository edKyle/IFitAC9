//
//  SettingViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/29.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    let funcArr = ["修改你的目標", "推播設定", "點數累積方式", "隱私權政策", "帳號登出"]
    
    @IBOutlet weak var settingTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        settingTableView.rowHeight = UITableViewAutomaticDimension
        settingTableView.estimatedRowHeight = 241
        
        settingTableView.registerNib(UINib(nibName: "SettingForQRCodeTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell0")
        
        settingTableView.registerNib(UINib(nibName: "SettingFuncTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.tabBarController?.tabBar.hidden = true
        CatTabbarViewController.catView.hidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        CatTabbarViewController.catView.hidden = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        
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

extension SettingViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 5
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = settingTableView.dequeueReusableCellWithIdentifier("Cell0", forIndexPath: indexPath) as! SettingForQRCodeTableViewCell
        
            return cell
        }else{
            let cell = settingTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SettingFuncTableViewCell
            cell.settingFuncLable.text = funcArr[indexPath.row]
            
            return cell
        }
    }
    
    
    
}
