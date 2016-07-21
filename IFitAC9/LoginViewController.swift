//
//  LoginViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/20.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = WKWebView(frame:UIScreen.mainScreen().bounds)
        self.view.addSubview(webView)
        let url = NSURL(string: "http://auth.i-fit.com.tw/login/")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        Alamofire.request(.GET, "http://auth.i-fit.com.tw/login/", parameters: ["redirect_uri": "http://alpha.i-fit.com.tw/ifit_user", "client_id":"alphacamp_app"])
            .responseJSON { response in
                
                print(response.request)  // 请求对象
                print(response.response) // 响应对象
                print(response.data)     // 服务端返回的数据
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                
        }
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
