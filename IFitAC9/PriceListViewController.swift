//
//  PriceListViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/27.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import CountdownLabel

class PriceListViewController: UIViewController {
    
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var priceViewIside: UIView!
    @IBOutlet weak var viewForPrice: UIView!
    @IBOutlet weak var priceListTableView: UITableView!
    @IBOutlet weak var countDownLable: CountdownLabel!
    @IBOutlet weak var codeLable: UILabel!
    
    @IBAction func startCountDonw(sender: AnyObject) {
        
        if priceButton.titleForState(.Normal) == "完成"{
            UIView.animateWithDuration(2, animations: {
                }, completion:{
                    success in
                    self.codeLable.hidden = true
                    self.countDownLable.hidden = true
                    self.countDownLable.setCountDownTime(0)
            })
        }else{
        priceButton.setTitle("確定兌換", forState: .Normal)
        countDownLable.hidden = false
        codeLable.hidden = false
        countDownLable.timeFormat = "ss"
        countDownLable.textColor = UIColor.blackColor()
        countDownLable.setCountDownTime(30)
        countDownLable.animationType = .Burn
        countDownLable.countdownDelegate = self
        
        countDownLable.start()
        
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "獎勵列表"
        self.tabBarController?.tabBar.hidden = true
        
        priceListTableView.dataSource = self
        priceListTableView.delegate = self
        
        priceListTableView.registerNib(UINib(nibName: "PriceDetailListTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        priceListTableView.rowHeight = UITableViewAutomaticDimension
        priceListTableView.estimatedRowHeight = 124
        
        viewForPrice.alpha = 0.8
        viewForPrice.hidden = true
        priceViewIside.hidden = true
        codeLable.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
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

extension PriceListViewController:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = priceListTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PriceDetailListTableViewCell
        cell.goPriceDelegate = self
        if indexPath.section == 0{
            cell.priceImageView.alpha = 1
            cell.getPriceButtonOutlet.setTitle("未兌換", forState: .Normal)
            cell.getPriceButtonOutlet.setBackgroundImage(UIImage(named: "buttonForPriceRed"), forState: .Normal)
        }
        
        if indexPath.section == 1{
            cell.priceImageView.alpha = 0.3
            cell.getPriceButtonOutlet.setTitle("未取得", forState: .Normal)
            cell.getPriceButtonOutlet.setBackgroundImage(UIImage(named: "buttonForPriceGray"), forState: .Normal)
        }
        
        
        return cell
        
    }
    
}

extension PriceListViewController: GoPriceDelegate{
    func canGo() {
        viewForPrice.hidden = false
        priceViewIside.hidden = false
    }
    
    
}

extension PriceListViewController: CountdownLabelDelegate {
    func countdownFinished() {
        
        UIView.animateWithDuration(2, animations: {
            }, completion:{
            success in
            self.priceButton.setTitle("確定兌換", forState: .Normal)
            self.viewForPrice.hidden = true
            self.priceViewIside.hidden = true
        })
    }
    
    func countingAt(timeCounted timeCounted: NSTimeInterval, timeRemaining: NSTimeInterval) {
        debugPrint("time counted at delegate=\(timeCounted)")
        debugPrint("time remaining at delegate=\(timeRemaining)")
        if timeRemaining == 30{
            self.priceButton.setTitle("完成", forState: .Normal)
        }
        if timeRemaining == 15{
            countDownLable.textColor = UIColor.redColor()
        }
    }
    
}


