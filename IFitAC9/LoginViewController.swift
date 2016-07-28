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
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingProgress: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.hidden = true
        loadingProgress.activityIndicatorViewStyle = .WhiteLarge
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
                    let json = JSON["datas"] as! NSArray
                    
                    print(json)
                    
                    let lastJsonData = json[json.count-1]
                    
                    lineRecordData.recordData.userPerfectWeightMax = "\(lastJsonData["standard"]!!["weight_upper"]!!)"
                    lineRecordData.recordData.userPerfectWeightMin = "\(lastJsonData["standard"]!!["weight_lower"]!!)"
                    
                    lineRecordData.recordData.userPerfectFatMax = "\(lastJsonData["standard"]!!["fat_rate_upper"]!!)"
                    lineRecordData.recordData.userPerfectFatMin = "\(lastJsonData["standard"]!!["fat_rate_lower"]!!)"
                    
                    lineRecordData.recordData.userPerfectMuscleMax = "\(lastJsonData["standard"]!!["muscle_weight_upper"]!!)"
                    lineRecordData.recordData.userPerfectMuscleMin = "\(lastJsonData["standard"]!!["muscle_weight_lower"]!!)"
                    
                    lineRecordData.recordData.userPerfectWaterMax = "\(lastJsonData["standard"]!!["water_rate_upper"]!!)"
                    lineRecordData.recordData.userPerfectWaterMin = "\(lastJsonData["standard"]!!["water_rate_lower"]!!)"
                    
                    
                    for n in json{
                        if let wei = n["composition"]!!["weight"]! {
                            lineRecordData.recordData.weight.append(Double(wei as! NSString as String)!)
                        }
                    }
                    
                    for n in json{
                        if let mus = n["composition"]!!["total_muscle"]! {
                            lineRecordData.recordData.musclePercent.append(Double(mus as! NSString as String)!)
                        }
                    }
                    
                    for n in json{
                        if let wat = n["composition"]!!["water_rate"]! {
                            lineRecordData.recordData.waterPercentage.append(wat as! NSNumber as Double)
                        }
                    }
                    for n in json{
                        if let fat = n["composition"]!!["total_fat"]! {
                            lineRecordData.recordData.fatPercentage.append(Double(fat as! NSString as String)!)
                        }
                    }
                    for n in json{
                        if let day = n["composition"]!!["updated_at"]! {
                            let dayString = day as! NSString as String!
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                            let dateNs = dateFormatter.dateFromString(dayString)
                            dateFormatter.dateStyle = .ShortStyle
                            
                            let calendar = NSCalendar.currentCalendar()
                            let components = calendar.components([.Day , .Month , .Year], fromDate: dateNs!)
                            
                            lineRecordData.recordData.measuringDate.append("\(components.month)/\(components.day)")
                        }
                    }
                    
                    self.performSegueWithIdentifier("logInSegue", sender: self)
                    
                }
                
        }
        Alamofire.request(.GET, "http://alpha.i-fit.com.tw/api/v1/advice_messages", parameters: ["user_id": 1])
            .responseJSON { response in
                
                if let advice = response.result.value{
                    let adviceArray = advice["datas"] as! NSArray
                    
                    for n in adviceArray{
                        let advice = n["message"]!! as! String
                        lineRecordData.recordData.userAdvice.append(advice)
                    }
                    
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
        print(codeArr)
        if codeArr[0] == "http://alpha.i-fit.com.tw/ifit_user?code"{
            webView.hidden = true
            loadingView.hidden = false
            let code = codeArr[1]
            print(codeArr)
            print("Hello code      " + code)
            let tokenFirst = codeToWebArr![3] as String
            let tokenArr = tokenFirst.componentsSeparatedByString("=")
            let token = tokenArr[1]
            print("Hello token    " + token)
            CurrentUser.user.token = token
            print(codeToWebArr)
            if code != "" && token != ""{
                Alamofire.request(.POST, "http://alpha.i-fit.com.tw/api/v1/login", parameters: ["code":code, "token": token, "callback": "", "state": ""])
                    .responseJSON { response in
                        
                        //                print(response.request)  // 请求对象
                        //                print(response.response) // 响应对象
                        //                print(response.data)     // 服务端返回的数据
                        
                        
                        if let JSON = response.result.value {
                            print("JSON: \(JSON)")
                            let status = JSON["data"] as! NSArray
                            print(status)
                            print(status[0])
                            let user = status[0]
                            print(user["name"]!)
                            CurrentUser.user.name = user["name"]! as? String
                            CurrentUser.user.menberID = user["user_id"]! as? String
                            CurrentUser.user.mPhoneNumber = user["mphone"]! as? String
                            CurrentUser.user.email = user["email"]! as? String
                            
                            self.getuserdata()
                        }
                        
                }
            }
        }
    }
}
