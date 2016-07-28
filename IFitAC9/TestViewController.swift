//
//  TestViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/25.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    var selectedRow: NSIndexPath?

    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    
    @IBAction func cancelButton(sender: AnyObject) {
        if self.navigationController != nil{
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("CatTabbarViewController") as! CatTabbarViewController
            self.showViewController(controller, sender: nil)
        }
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TestTableViewCell
//        cell.accessoryView = UIImageView(image: UIImage(named: "check"))
        let paths:[NSIndexPath]
        self.nextButtonOutlet.backgroundColor = UIColor(red: 255/255, green: 204/255, blue: 102/255, alpha: 1)
        self.nextButtonOutlet.layer.shadowColor = UIColor(red: 99/255, green: 63/255, blue: 30/255, alpha: 1).CGColor
        self.nextButtonOutlet.layer.shadowOpacity = 5
        self.nextButtonOutlet.layer.shadowRadius = 3
        self.nextButtonOutlet.layer.shouldRasterize = true
        
        if let previous = selectedRow {
            paths = [indexPath, previous]
        } else {
            paths = [indexPath]
        }
        selectedRow = indexPath
        answerTableView.reloadRowsAtIndexPaths(paths, withRowAnimation: .Automatic)

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = answerTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TestTableViewCell
        
        
        if indexPath == selectedRow {
            cell.accessoryView = UIImageView(image: UIImage(named: "check"))
        } else {
            cell.accessoryView = .None
        }

        cell.answerLable.text = answerArr[indexPath.row]

        
        return cell
    }
    
    
}









