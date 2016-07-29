//
//  CatTabbarViewController.swift
//  IFitAC9
//
//  Created by Kyle on 7/26/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit
import AVFoundation

class CatTabbarViewController: UITabBarController{
    
    var count = 0
    static var notificationUrl:String?
    static var notification = false
    
    var point = CGPoint()
    var beginTouch = UITouch()
    static var catView = UIImageView()
    var audioPlayer = AVAudioPlayer()
    var qRCodeView = shakeMyCardViewViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.changeCat), name: "Notifi", object: nil)
        
        
        
        let catSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Lion sound effects", ofType: "mp3")!)
        do{
            try audioPlayer = AVAudioPlayer(contentsOfURL: catSound)
        }catch{
            print(error)
        }
        audioPlayer.prepareToPlay()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        CatTabbarViewController.catView = UIImageView(frame:CGRect(x: 200, y: 0, width: 50, height: 50))
        CatTabbarViewController.catView.transform = CGAffineTransformIdentity
        
        CatTabbarViewController.catView.userInteractionEnabled = true
        CatTabbarViewController.catView.contentMode = .ScaleAspectFit
        CatTabbarViewController.catView.image = UIImage(named: "降落傘")
        self.view.addSubview(CatTabbarViewController.catView)
        
        
        UIView.animateWithDuration(1.6, animations: {
            
            CatTabbarViewController.catView.transform = CGAffineTransformMakeTranslation(-200, UIScreen.mainScreen().bounds.height-113)
            
            CatTabbarViewController.catView.frame.size = CGSize(width: 80, height: 80)
            
            
        }) { (nil) in
            CatTabbarViewController.catView.image = UIImage(named: "躺在_tab_bar_的貓貓")
            
            if CatTabbarViewController.notification == true{
                CatTabbarViewController.catView.image = UIImage(named: "有對話框的貓貓")
                CatTabbarViewController.catView.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-113, width: 100, height: 100)
                AudioServicesPlaySystemSound (1000)
            }
            
        }
        
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.beginTouch = touches.first!
        self.count = 0
        if CatTabbarViewController.notification == true{
            CatTabbarViewController.catView.image = UIImage(named: "躺在_tab_bar_的貓貓")
            CatTabbarViewController.notification = false
            CatTabbarViewController.catView.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-113, width: 80, height: 80)
        }
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if beginTouch.view == CatTabbarViewController.catView{
            self.count = 1
            CatTabbarViewController.catView.transform = CGAffineTransformMakeTranslation(0, 0)
            CatTabbarViewController.catView.image = UIImage(named: "抓起")
            CatTabbarViewController.catView.frame.size = CGSize(width: 100, height: 100)
            point = self.beginTouch.locationInView(CatTabbarViewController.catView.superview)
            CatTabbarViewController.catView.center = point
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.beginTouch.view == CatTabbarViewController.catView{
        
        if self.count == 0{
           
            audioPlayer.play()
            
            print(lineRecordData.recordData.userAdvice)
            
            if CatTabbarViewController.notificationUrl != nil{
            let url = NSURL(string: CatTabbarViewController.notificationUrl!)
                print(url)
            UIApplication.sharedApplication().openURL(url!)
            }
            return
        }
       CatTabbarViewController.catView.frame.size = CGSize(width: 50, height: 50)
        
        UIView.animateWithDuration(1.6, animations: {
                
                CatTabbarViewController.catView.frame.size = CGSize(width: 80, height: 80)
                CatTabbarViewController.catView.image = UIImage(named: "降落傘")
               CatTabbarViewController.catView.frame.origin.y = UIScreen.mainScreen().bounds.height-113
                
                let random = CGFloat(arc4random_uniform(200))
                CatTabbarViewController.catView.frame.origin.x = random
                
                self.swing()
                self.swing()
                
            }) { (nil) in
                CatTabbarViewController.catView.image = UIImage(named: "躺在_tab_bar_的貓貓")
                if CatTabbarViewController.notification == true{
                    CatTabbarViewController.catView.image = UIImage(named: "有對話框的貓貓")
                }
            }
        }
    }
    
    //MARK: Tim 搖搖QRCode
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake{
            let width = UIScreen.mainScreen().bounds.width
            let height = UIScreen.mainScreen().bounds.height
            qRCodeView.view.frame.size = CGSize(width: width, height: height)
            qRCodeView.dismissDelegate = self
            self.view.addSubview(qRCodeView.view)
            
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        
    }
    
    
    func swing(){
        UIView.animateWithDuration(0.8, delay: 0, options: .AllowUserInteraction, animations: {
            Void in
            CatTabbarViewController.catView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/8))
            }, completion:{
                succeed in
                UIView.animateWithDuration(0.8, delay: 0, options: .AllowUserInteraction, animations: {
                    Void in
                   CatTabbarViewController.catView.transform = CGAffineTransformMakeRotation(CGFloat(0))
                    }, completion:{
                        succeed in
                })
        })
        
    }
    
    
    func changeCat(){
        CatTabbarViewController.catView.image = UIImage(named: "有對話框的貓貓")
        CatTabbarViewController.catView.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-113, width: 100, height: 100)
        AudioServicesPlaySystemSound (1000)
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

extension CatTabbarViewController: DismissQRCodeDelegatr{
    func dismiss() {
        self.qRCodeView.view.removeFromSuperview()
    }
}
