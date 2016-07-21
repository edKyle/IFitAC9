//
//  PriceDetailViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/19.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import BetterSegmentedControl


class PriceDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        

        tableView.registerNib(UINib(nibName: "PriceDetailFirstRowTableViewCell", bundle: nil), forCellReuseIdentifier: "CellForFirstRow")
        
        tableView.registerNib(UINib(nibName: "PriceDetailSecondRowTableViewCell", bundle: nil), forCellReuseIdentifier: "CellForSecondRow")
        
        tableView.registerNib(UINib(nibName: "PriceDetailThirdRowTableViewCell", bundle: nil), forCellReuseIdentifier: "CellForThirdRow")
        
        let control = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 44.0),
            titles: ["15 Point", "30 Point", "50 Point"],
            index: 1,
            backgroundColor: UIColor(red:0.11, green:0.12, blue:0.13, alpha:1.00),
            titleColor: .whiteColor(),
            indicatorViewBackgroundColor: UIColor(red:0.55, green:0.26, blue:0.86, alpha:1.00),
            selectedTitleColor: .blackColor())
        control.titleFont = UIFont(name: "HelveticaNeue", size: 14.0)!
        control.selectedTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 14.0)!
        control.addTarget(self, action: #selector(PriceDetailViewController.navigationSegmentedControlValueChanged(_:)), forControlEvents: .ValueChanged)
        tableView.addSubview(control)
        

        // Do any additional setup after loading the view.
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


extension PriceDetailViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellForFirstRow", forIndexPath: indexPath) as! PriceDetailFirstRowTableViewCell
        
        let cellForSecondRow = tableView.dequeueReusableCellWithIdentifier("CellForSecondRow", forIndexPath: indexPath) as! PriceDetailSecondRowTableViewCell
        
        let cellForThirdRow = tableView.dequeueReusableCellWithIdentifier("CellForThirdRow", forIndexPath:  indexPath) as! PriceDetailThirdRowTableViewCell
         
        cell.imageViewHeightConstraint.constant = UIScreen.mainScreen().bounds.height / 3
        cellForSecondRow.collectionViewHeight.constant = UIScreen.mainScreen().bounds.height / 4
//        cellForThirdRow.collectionViewHeight.constant = UIScreen.mainScreen().bounds.height 
        
        if indexPath.row == 0{
            return cell
        }else if indexPath.row == 1{
            return cellForSecondRow
        }else if indexPath.row == 2{
            return cellForThirdRow
        }
        return cell
    }
    
    
}

extension PriceDetailViewController: UITableViewDelegate {
 
}