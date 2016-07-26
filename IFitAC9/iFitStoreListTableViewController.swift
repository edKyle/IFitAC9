//
//  iFitStoreListTableViewController.swift
//  IFitAC9
//
//  Created by Kyle on 7/20/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit
import CoreLocation

// 宣告 locationManger 全域變數
let locationManger = CLLocationManager()

class iFitStoreListTableViewController: UITableViewController, CLLocationManagerDelegate{
    
    let storeArray = ["store1","store2","store3","store4","store5","store6","store7","store8","store9"]
    
    var AllStoreLocation = [["iFit shop":"iFit東區延吉店","lat":"25.040506","long":"121.554871"],
                            ["iFit shop":"iFit北投店","lat":"25.116473","long":"121.509762"],
                            ["iFit shop":"iFit新店店","lat":"24.957446","long":"121.537943"],
                            ["iFit shop":"iFit南勢角店","lat":"25.009913","long":"121.513911"],
                            ["iFit shop":"iFit永安市場店","lat":"25.002921","long":"121.514980"],
                            ["iFit shop":"iFit大潤發店","lat":"25.062902","long":"121.575896"],
                            ["iFit shop":"iFit延平保安店","lat":"25.059057","long":"121.511341"],
                            ["iFit shop":"iFit東興家樂福店","lat":"25.048147","long":"121.566042"],
                            ["iFit shop":"iFit桃園婦女館","lat":"24.981403","long":"121.315387"]
                            ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        
        let nibName = UINib(nibName: "iFitStoreListTableViewCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "ifitStoreCell")
        
        let nibName2 = UINib(nibName: "topTableViewCell", bundle:nil)
        self.tableView.registerNib(nibName2, forCellReuseIdentifier: "topCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return 1
        case 1:
            return 9
        default:
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("topCell", forIndexPath: indexPath) as! topTableViewCell
            cell.topCellImageView.image = UIImage(named: "iFit")
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("ifitStoreCell", forIndexPath: indexPath) as! iFitStoreListTableViewCell
            
            cell.storeImageView.image = UIImage(named: storeArray[indexPath.row])
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("topCell", forIndexPath: indexPath) as! topTableViewCell
            cell.topCellImageView.image = UIImage(named: "")
            return cell
            
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section{
        case 0:
            break
        case 1:
            performSegue(AllStoreLocation[indexPath.row])
        default:
            break
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    // 點圖片將 store 位置資訊傳給 MapViewController.theStoreUserTap
    func performSegue(AllStoreLocation:[String:String]){
        performSegueWithIdentifier("showMap", sender: self)
        MapViewController.theStoreUserTap = AllStoreLocation
    }
}
