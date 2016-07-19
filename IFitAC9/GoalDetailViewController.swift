//
//  GoalDetailViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/19.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class GoalDetailViewController: UIViewController {
    
    var archievementList = ["至門市檢測一次", "體脂在標準值內","門市踩點（Center)", "門市踩點（else)", "第一次檢測", "第二次檢測", "第三次檢測", "BMI合乎標準", "體脂率合乎標準", "肌肉量合乎標準", "含水量合乎標準", "BMI下降", "BMI維持 IF 合格", "體脂率下降", "體脂率維持 IF 合格", "肌肉量上升", "肌肉量維持 IF 合格"]

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
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

extension GoalDetailViewController:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        return cell
    }
}
