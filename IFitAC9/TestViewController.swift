//
//  TestViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/25.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
 
    let answerArr = ["規律運動，飲食健康生活", "減重為重心的積極生活", "認真健身的運動生活"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        self.tabBarController?.tabBar.hidden = true
        
        answerTableView.dataSource = self
        answerTableView.delegate = self
        
        answerTableView.registerNib(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        let tableViewHeight = answerTableView.frame.height
        
        answerTableView.rowHeight = tableViewHeight/CGFloat(answerArr.count)
        answerTableView.estimatedRowHeight = tableViewHeight/CGFloat(answerArr.count)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
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

extension TestViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = answerTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TestTableViewCell
        
        cell.answerLable.text = answerArr[indexPath.row]
        
        return cell
    }
    
    
}









