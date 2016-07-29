//
//  shakeMyCardViewViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/29.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

protocol DismissQRCodeDelegatr:class {
    func dismiss()
}

class shakeMyCardViewViewController: UIViewController {
    
    weak var dismissDelegate:DismissQRCodeDelegatr?

    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var qRCodeImageView: UIImageView!
    
    @IBAction func dismissAction(sender: AnyObject) {
        dismissDelegate!.dismiss()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qRCodeImageView.image = CurrentUser.user.getUserQRCode()
        coverView.alpha = 0.8
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
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
