//
//  BubbleViewController.swift
//  IFitAC9
//
//  Created by YeouTimothy on 2016/7/21.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit
import SpriteKit

class BubbleViewController: UIViewController {
    
    private var skView: SKView!
    private var floatingCollectionScene: BubblesScene!
    
    @IBOutlet weak var viewForBubble: UIView!
    @IBOutlet weak var viewForBubbletwisterPart: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView = SKView(frame: viewForBubble.bounds)
        
        skView.backgroundColor = SKColor.blackColor()
        viewForBubble.addSubview(skView)
        
        floatingCollectionScene = BubblesScene(size: skView.bounds.size)
        
        
//        let navBarHeight = CGRectGetHeight(navigationController!.navigationBar.frame)
//        let statusBarHeight = CGRectGetHeight(UIApplication.sharedApplication().statusBarFrame)
        floatingCollectionScene.topOffset = 0
        floatingCollectionScene.bottomOffset = 0
        
        skView.presentScene(floatingCollectionScene)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .Done,
            target: self,
            action: #selector(BubbleViewController.commitSelection)
        )
        
        for _ in 0..<40 {
            let node = BubbleNode.instantiate()
            floatingCollectionScene.addChild(node)
        }
    }
    
    dynamic private func commitSelection() {
        floatingCollectionScene.performCommitSelectionAnimation()
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
