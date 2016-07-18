//
//  ViewController.swift
//  lineTry
//
//  Created by Kyle on 7/12/16.
//  Copyright © 2016 Alphacamp. All rights reserved.
//

import UIKit


class UserViewController: UIViewController{
    
    var graphView:ScrollableGraphView?

    var data: [Double] = [59,35,78,80,90,20,90,30,49]
    var labels:[String] = []

    static var mainImageViewArray:[UIImageView] = []
    var viewalready = false
    
    @IBOutlet weak var lineView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if viewalready == true{
            self.graphView!.removeFromSuperview()
            viewalready = false

        }
        makeLineView()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        for point in ScrollableGraphView.viewArray{
            let pictureView = UIImageView(frame:CGRect(x: point.x, y: 280, width: 50, height: 50))
            pictureView.image = UIImage(named: "2")
            
            UIView.animateWithDuration(2, animations: {
                
                pictureView.frame.origin.x = point.x - 25
                pictureView.frame.origin.y = point.y - 25
                
                self.graphView!.addSubview(pictureView)
                self.viewalready = true
            })
        }

     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func makeLineView(){
        
        graphView = nil
        graphView = ScrollableGraphView(frame: CGRectMake ( 0, 0, 300, 250))
        
        graphView!.dataPointType = .Circle
        
        graphView!.referenceLineLabelColor = UIColor.purpleColor()
        graphView!.referenceLineColor = UIColor.clearColor()
        graphView!.numberOfIntermediateReferenceLines = 9
        
        graphView!.backgroundFillColor = UIColor.clearColor()
        graphView!.lineColor = UIColor.purpleColor()
        graphView!.dataPointLabelColor = UIColor.purpleColor()
        graphView!.dataPointFillColor = UIColor.clearColor()
        
        for i in 1...data.count+1{
            labels.append("\(i)")
        }
        
        graphView!.setData(data, withLabels: labels)
       
        self.lineView.addSubview(graphView!)
        
    }
}

