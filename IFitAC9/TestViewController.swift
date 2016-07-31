//
//  TestViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/25.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import Alamofire

class TestViewController: UIViewController {
    
    var selectedRow: NSIndexPath?
    var whereYouFrom = 0
    var currentQuestion = 0
    let outcomePage = TestOutcomeViewController()

    @IBOutlet weak var nextButtonOutlet: UIButton!
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var questionNum: UILabel!
    
    @IBAction func cancelButton(sender: AnyObject) {
        if self.navigationController != nil{
            self.navigationController?.popViewControllerAnimated(true)
        }else{
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("CatTabbarViewController") as! CatTabbarViewController
            self.showViewController(controller, sender: nil)
        }
    }
    
    @IBAction func nextButtonAction(sender: AnyObject) {
        if whereYouFrom == 0{
            
            let width = UIScreen.mainScreen().bounds.width
            let height = UIScreen.mainScreen().bounds.height
            outcomePage.view.frame.size = CGSize(width: width, height: height)
            self.view.addSubview(outcomePage.view)
            outcomePage.dismissDelegate = self

            
        }else if currentQuestion == 0{
            currentQuestion += 1
            nextButtonOutlet.setTitle("完成", forState: .Normal)
            questionNum.text = "2/2"
            questionLable.text = questionArr[currentQuestion]
            answerTableView.reloadData()
        }else if currentQuestion == 1{
            let width = UIScreen.mainScreen().bounds.width
            let height = UIScreen.mainScreen().bounds.height
            outcomePage.view.frame.size = CGSize(width: width, height: height)
            
            self.view.addSubview(outcomePage.view)
            outcomePage.dismissDelegate = self
        }
    }
    
    let questionFromLogin = ["你想要哪種瘦身生活？"]
    
    let answerFromLogin = ["規律運動，飲食健康生活", "減重為重心的積極生活", "認真健身的運動生活"]
    
    let questionArr = ["你的目標？", "平常一週運動頻率是？"]
    let answerArr = ["規律運動，飲食健康生活", "減重為重心的積極生活", "認真健身的運動生活", "很少", "一個月一次", "兩個禮拜一次"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        self.tabBarController?.tabBar.hidden = true
        CatTabbarViewController.catView.hidden = true
        
        answerTableView.dataSource = self
        answerTableView.delegate = self
        
        answerTableView.registerNib(UINib(nibName: "TestTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        let tableViewHeight = answerTableView.frame.height
        
        answerTableView.rowHeight = tableViewHeight/CGFloat(answerArr.count/2)
        answerTableView.estimatedRowHeight = tableViewHeight/CGFloat(answerArr.count/2)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        if whereYouFrom == 0{
            nextButtonOutlet.setTitle("完成", forState: .Normal)
            questionLable.text = questionFromLogin[0]
            questionNum.text = "1/1"
        }else{
            questionLable.text = questionArr[0]
            questionNum.text = "1/2"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
        self.tabBarController?.tabBar.hidden = false
        CatTabbarViewController.catView.hidden = false
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
        
        if currentQuestion == 0{
            cell.answerLable.text = answerArr[indexPath.row]
        }else{
            cell.answerLable.text = answerArr[indexPath.row + 3]
        }
        
        return cell
    }
}

extension TestViewController: DismissQRCodeDelegatr{
    
    func dismiss() {
        print(CurrentUser.user.menberID)
        Alamofire.request(.POST, "http://alpha.i-fit.com.tw/api/v1/user_type", parameters: ["user_id":CurrentUser.user.menberID!, "user_type": "0"])
            .responseJSON { response in
                
                //                print(response.request)  // 请求对象
                //                print(response.response) // 响应对象
                //                print(response.data)     // 服务端返回的数据
                
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let userType = JSON["user_type"] as? Int
                    print(userType)
                    CurrentUser.user.userType = userType

                        self.cancelButton(self)

                }
        }
    }
    
}









