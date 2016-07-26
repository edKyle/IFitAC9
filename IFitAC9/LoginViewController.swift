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
import SwiftyJSON

class LoginViewController: UIViewController {
    
    let webView = WKWebView(frame:UIScreen.mainScreen().bounds)
    let url = NSURL(string: "http://auth.i-fit.com.tw/login?redirect_uri=http://alpha.i-fit.com.tw/ifit_user&client_id=alphacamp_web&scope=&state=&callback=")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let request = NSURLRequest(URL: url!)
        self.view.addSubview(webView)
        
        webView.loadRequest(request)
        print(request.URL?.absoluteString)
        //        Alamofire.request(.POST, "http://auth.i-fit.com.tw/login/", parameters: ["state": "http://alpha.i-fit.com.tw/ifit_user", "client_id":"alphacamp_app"])
        //            .responseJSON { response in
        //
        //                print(response.request)  // 请求对象
        //                print(response.response) // 响应对象
        //                print(response.data)     // 服务端返回的数据
        //
        //                if let JSON = response.result.value {
        //                    print("JSON: \(JSON)")
        //                }
        //
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getuserdata(){
        Alamofire.request(.GET, "http://alpha.i-fit.com.tw/api/v1/compositions", parameters: ["user_id": 1])
            .responseJSON { response in
                
                print(response.request)  // 请求对象
                print(response.response) // 响应对象
                print(response.data)     // 服务端返回的数据
                
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let status = JSON["data"]
                    print("To other View hewe")
                    
                }
                
        }

    }
    
}

extension LoginViewController:WKNavigationDelegate{
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("Finished navigating to url \(self.webView.URL?.absoluteString)")
        let codeToWebArr = self.webView.URL?.absoluteString.componentsSeparatedByString("&")
        print(codeToWebArr)
        let codeFirst = codeToWebArr![0] as String
        let codeArr = codeFirst.componentsSeparatedByString("=")
        let code = codeArr[1]
        print(codeArr)
        print("Hello code      " + code)
        let tokenFirst = codeToWebArr![3] as String
        let tokenArr = tokenFirst.componentsSeparatedByString("=")
        let token = tokenArr[1]
        print("Hello token    " + token)
        print(codeToWebArr)
        Alamofire.request(.POST, "http://alpha.i-fit.com.tw/api/v1/login", parameters: ["code":code, "token": token, "callback": "", "state": ""])
            .responseJSON { response in
                
                print(response.request)  // 请求对象
                print(response.response) // 响应对象
                print(response.data)     // 服务端返回的数据
                
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let status = JSON["data"]
                    self.getuserdata()
                }
                
        }
    }
}
