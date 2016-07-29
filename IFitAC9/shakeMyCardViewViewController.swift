//
//  shakeMyCardViewViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/29.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class shakeMyCardViewViewController: UIViewController {

    @IBOutlet weak var qRCodeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qRCodeImageView.image = CurrentUser.user.getUserQRCode()
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
