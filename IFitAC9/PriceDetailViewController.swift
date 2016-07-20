//
//  PriceDetailViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/19.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class PriceDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        

        tableView.registerNib(UINib(nibName: "PriceDetailFirstRowTableViewCell", bundle: nil), forCellReuseIdentifier: "CellForFirstRow")
        
        tableView.registerNib(UINib(nibName: "PriceDetailSecondRowTableViewCell", bundle: nil), forCellReuseIdentifier: "CellForSecondRow")
        
        tableView.registerNib(UINib(nibName: "PriceDetailThirdRowCollectionViewCell", bundle: nil), forCellReuseIdentifier: "CellForThirdRow")

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


extension PriceDetailViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellForFirstRow", forIndexPath: indexPath) as! PriceDetailFirstRowTableViewCell
        
        let cellForSecondRow = tableView.dequeueReusableCellWithIdentifier("CellForSecondRow", forIndexPath: indexPath) as! PriceDetailSecondRowTableViewCell
        
        let cellForThirdRow = tableView.dequeueReusableCellWithIdentifier("CellForThirdRow", forIndexPath:  indexPath) as! PriceDetailThirdRowCollectionViewCell
        
        cell.imageViewHeightConstraint.constant = UIScreen.mainScreen().bounds.height / 3
        cellForSecondRow.collectionViewHeight.constant = UIScreen.mainScreen().bounds.height / 4
        
        if indexPath.row == 0{
            return cell
        }else if indexPath.row == 1{
            return cellForSecondRow
        }else{
            return cellForThirdRow
        }
    }
    
    
}