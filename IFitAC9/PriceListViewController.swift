//
//  PriceListViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/27.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class PriceListViewController: UIViewController {

    @IBOutlet weak var priceListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "獎勵列表"
                
        priceListTableView.dataSource = self
        priceListTableView.delegate = self
        
        priceListTableView.registerNib(UINib(nibName: "PriceDetailListTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        priceListTableView.rowHeight = UITableViewAutomaticDimension
        priceListTableView.estimatedRowHeight = 124
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

extension PriceListViewController:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = priceListTableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! PriceDetailListTableViewCell
        
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
