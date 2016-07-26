//
//  BubbleViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/21.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import Foundation



class BubbleViewController: UIViewController {
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    var screenHeight = UIScreen.mainScreen().bounds.height
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var square: UIView!
    var snap: UISnapBehavior!
    var handllerImage:UIImageView?
    var handllerView:UIView?
    var circleArr = [UIView]()

    @IBOutlet weak var viewForBubble: UIView!
    
    @IBAction func twistAction(sender: AnyObject) {
        UIView.animateWithDuration(0.5, delay: 0.3, options: .CurveEaseOut, animations: {self.handllerView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI)
            )}, completion: {
                bool in
                UIView.animateWithDuration(0.5, delay: 0.3, options: .CurveEaseOut, animations: {self.handllerView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI*2))}, completion: nil
                )
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        handllerView = UIView(frame: CGRect(x: (screenWidth/6) * 4 , y: (screenHeight/2), width: 70, height: 50))
        handllerImage = UIImageView(frame: CGRectMake(0 , 0, 70, 50))
        
        handllerImage!.image = UIImage(named: "bubbleTwisterHandleller")
        handllerView!.addSubview(handllerImage!)
        view.addSubview(handllerView!)
        
        let navigationBarHeight = self.navigationController?.navigationBar.bounds.height
        screenHeight += navigationBarHeight!
//        self.navigationController?.navigationBar.hidden = true
//        self.tabBarController?.tabBar.hidden = true
        
        
        
        // Create Path
        let bezierPath = UIBezierPath()
        
        // Draw Points
        bezierPath.moveToPoint(CGPointMake(0, screenHeight/3))
        bezierPath.addLineToPoint(CGPointMake(screenWidth/2, screenHeight/2))
        bezierPath.addLineToPoint(CGPointMake(0, screenHeight/2))
        bezierPath.addLineToPoint(CGPointMake(0, screenHeight/3))
        bezierPath.closePath()
        UIColor.greenColor().setFill()
        bezierPath.fill()
        
        
        let bezierPath2 = UIBezierPath()
        
        bezierPath2.moveToPoint(CGPointMake(screenWidth, screenHeight/3))
        bezierPath2.addLineToPoint(CGPointMake(screenWidth/2, screenHeight/2))
        bezierPath2.addLineToPoint(CGPointMake(screenWidth, screenHeight/2))
        bezierPath2.addLineToPoint(CGPointMake(screenWidth, screenHeight/3))
        bezierPath2.closePath()
        
        
        // Apply Color
        
        
        for i in 0...30{
            square = UIView(frame: CGRect(x: screenWidth/2 , y: 0, width: 45, height: 45))
            if i%3 == 1{
                square.backgroundColor = UIColor.redColor()
            }else if i%3 == 2{
                square.backgroundColor = UIColor.blueColor()
            }else{
                square.backgroundColor = UIColor.yellowColor()
            }
            
            square.layer.cornerRadius = square.frame.size.width/2
            square.clipsToBounds = true
            circleArr.append(square)
        }
        
        for i in circleArr{
            view.addSubview(i)
        }
        
        
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: circleArr)
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: circleArr)
        collision.collisionDelegate = self
        collision.action = {
            //            print("\(NSStringFromCGAffineTransform(square.transform)) \(NSStringFromCGPoint(square.center))")
        }
        collision.addBoundaryWithIdentifier("barrier", forPath: bezierPath2)
        
        collision.addBoundaryWithIdentifier("triangle", forPath: bezierPath)
        
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        
        let itemBehaviour = UIDynamicItemBehavior(items: circleArr)
        itemBehaviour.elasticity = 0.6
        animator.addBehavior(itemBehaviour)

    
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

extension BubbleViewController: UICollisionBehaviorDelegate{
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        
        if let touch = touches.first{
            snap = UISnapBehavior(item: circleArr[Int(arc4random()%10)], snapToPoint: touch.locationInView(view))
            animator.addBehavior(snap)
        }
        
    }
    
}
