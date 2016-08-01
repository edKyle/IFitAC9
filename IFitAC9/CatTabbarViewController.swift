//
//  CatTabbarViewController.swift
//  IFitAC9
//
//  Created by Kyle on 7/26/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit
import AVFoundation
import GestureRecognizerClosures

class CatTabbarViewController: UITabBarController{
    
    var hasBeenMove = false
    static var notificationUrl:String?
    static var notificationMessage:String?
    static var notification = false
    
    var point = CGPoint()
    var beginTouch = UITouch()
    static var catView = UIImageView()
    var audioPlayer = AVAudioPlayer()
    var qRCodeView = shakeMyCardViewViewController()
    var messageViewController = tapCatViewController()
    
    // sound effect
    var soundEffect = ["貓叫聲","cat1b"]
    var catSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("貓叫聲", ofType: "mp3")!)
    var voiceCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.changeCat), name: "Notifi", object: nil)
        
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
        self.hasBeenMove = false
    
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if beginTouch.view == CatTabbarViewController.catView{
            self.hasBeenMove = true
            CatTabbarViewController.catView.transform = CGAffineTransformMakeTranslation(0, 0)
            CatTabbarViewController.catView.image = UIImage(named: "抓起")
            CatTabbarViewController.catView.frame.size = CGSize(width: 120, height: 120)
            point = self.beginTouch.locationInView(CatTabbarViewController.catView.superview)
            CatTabbarViewController.catView.center = CGPoint(x: point.x-60, y: point.y+60)
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.beginTouch.view == CatTabbarViewController.catView{
        
        if self.hasBeenMove == false{
            
            if voiceCount == 1{
                voiceCount = 0
            }else{
                voiceCount += 1
            }
            self.catVoice()

            let width = UIScreen.mainScreen().bounds.width
            let height = UIScreen.mainScreen().bounds.height
            messageViewController.view.frame.size = CGSize(width: width, height: height)
            self.view.addSubview(messageViewController.view)
            
            if lineRecordData.recordData.userAdvice != []{
            let random = Int(arc4random_uniform(UInt32(lineRecordData.recordData.userAdvice.count)))
            messageViewController.messageContentLabel.text = "喵～\(lineRecordData.recordData.userAdvice[random])"
            }else{
                messageViewController.messageContentLabel.text = "喵～"
            }
            
            if CatTabbarViewController.notification == true{
                CatTabbarViewController.catView.image = UIImage(named: "躺在_tab_bar_的貓貓")
                CatTabbarViewController.notification = false
               
                CatTabbarViewController.catView.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-113, width: 80, height: 80)

                if CatTabbarViewController.notificationUrl != nil{
                    var url = NSURL(string: CatTabbarViewController.notificationUrl!)
                    UIApplication.sharedApplication().openURL(url!)
                    url = nil
                    CatTabbarViewController.notificationUrl = nil
                }
                if CatTabbarViewController.notificationMessage != nil{
                    messageViewController.messageContentLabel.text = "喵～\(CatTabbarViewController.notificationMessage!)"
                }
            }
            messageViewController.messageButton.onTap({ (UITapGestureRecognizer) in
                self.messageViewController.view.removeFromSuperview()
            })
            messageViewController.cancleButton.onTap({ (UITapGestureRecognizer) in
                self.messageViewController.view.removeFromSuperview()
            })

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
                    CatTabbarViewController.catView.frame.size = CGSize(width: 100, height: 100)

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
    func catVoice(){
        self.catSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundEffect[voiceCount], ofType: "mp3")!)
        do{
            try audioPlayer = AVAudioPlayer(contentsOfURL: catSound)
        }catch{
            print(error)
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}
