//
//  CatTabbarViewController.swift
//  IFitAC9
//
//  Created by Kyle on 7/26/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit
import AVFoundation

class CatTabbarViewController: UITabBarController {
    
    var count = 0
    static var notification = false
    var point = CGPoint()
    var beginTouch = UITouch()
    var catView = UIImageView()
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        catView = UIImageView(frame:CGRect(x: 200, y: 0, width: 50, height: 50))
        self.catView.transform = CGAffineTransformIdentity
        
        catView.userInteractionEnabled = true
        catView.contentMode = .ScaleAspectFit
        catView.image = UIImage(named: "降落傘")
        self.view.addSubview(catView)

        
        UIView.animateWithDuration(1.6, animations: {
            
            self.catView.transform = CGAffineTransformMakeTranslation(-200, UIScreen.mainScreen().bounds.height-113)
            
            self.catView.frame.size = CGSize(width: 80, height: 80)
            
            
        }) { (nil) in
            self.catView.image = UIImage(named: "躺在_tab_bar_的貓貓")
            
            if CatTabbarViewController.notification == true{
                self.catView.image = UIImage(named: "有對話框的貓貓")
                self.catView.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-113, width: 100, height: 100)
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
            catView.image = UIImage(named: "躺在_tab_bar_的貓貓")
            CatTabbarViewController.notification = false
                           self.catView.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-113, width: 80, height: 80)
        }
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if beginTouch.view == self.catView{
            self.count = 1
            self.catView.transform = CGAffineTransformMakeTranslation(0, 0)
            self.catView.image = UIImage(named: "抓起")
            self.catView.frame.size = CGSize(width: 100, height: 100)
            point = self.beginTouch.locationInView(self.catView.superview)
            self.catView.center = point
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.count == 0{
            audioPlayer.play()
            print(lineRecordData.recordData.userAdvice)
            
            return
        }
        self.catView.frame.size = CGSize(width: 50, height: 50)
        
        UIView.animateWithDuration(1.6, animations: {
            if self.beginTouch.view == self.catView{
                
                self.catView.frame.size = CGSize(width: 80, height: 80)
                self.catView.image = UIImage(named: "降落傘")
                self.catView.frame.origin.y = UIScreen.mainScreen().bounds.height-113
                
                let random = CGFloat(arc4random_uniform(200))
                self.catView.frame.origin.x = random
                
                self.swing()
                self.swing()
                
            }}) { (nil) in
                self.catView.image = UIImage(named: "躺在_tab_bar_的貓貓")
                if CatTabbarViewController.notification == true{
                    self.catView.image = UIImage(named: "有對話框的貓貓")
                }
        }
    }
    
    
    func swing(){
        UIView.animateWithDuration(0.8, delay: 0, options: .AllowUserInteraction, animations: {
            Void in
            self.catView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/8))
            }, completion:{
                succeed in
                UIView.animateWithDuration(0.8, delay: 0, options: .AllowUserInteraction, animations: {
                    Void in
                    self.catView.transform = CGAffineTransformMakeRotation(CGFloat(0))
                    }, completion:{
                        succeed in
                })
        })
        
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
