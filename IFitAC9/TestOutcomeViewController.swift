//
//  TestOutcomeViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/31.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import Alamofire

class TestOutcomeViewController: UIViewController {
    
    weak var dismissDelegate:DismissQRCodeDelegatr?

   
    @IBAction func cacelAction(sender: AnyObject) {
        dismissDelegate?.dismiss()
    }
    
    @IBAction func postAction(sender: AnyObject) {
        dismissDelegate?.dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hooooo")
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
