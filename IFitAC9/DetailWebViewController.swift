//
//  DetailWebViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/28.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import WebKit

class DetailWebViewController: UIViewController {
    
    let webView = WKWebView(frame:UIScreen.mainScreen().bounds)
    var urlStr:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: urlStr!)
        let request = NSURLRequest(URL: url!)
        view.addSubview(webView)
        webView.loadRequest(request)

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
