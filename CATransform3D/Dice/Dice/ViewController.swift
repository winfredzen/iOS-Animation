//
//  ViewController.swift
//  Dice
//
//  Created by 王振 on 2018/4/17.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var blueView: UIView!
    
    var angle = CGPoint.init(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //viewTransform()
        
        let subView = UIView.init(frame: blueView.bounds)
        subView.backgroundColor = UIColor.blue
        blueView.addSubview(subView)
        blueView.backgroundColor = UIColor.clear
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTransform(sender:)))
        blueView.addGestureRecognizer(panGesture)
        
    }
    
    /*
    func viewTransform() {
        var transform = CATransform3DIdentity
        let angle = CGFloat(45)
        transform.m34 = -1 / 500 // 透视
        blueView.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0)
    }
    */
    
    @objc func viewTransform(sender: UIPanGestureRecognizer) {
        // translation表示的是持续变化的量，并不是相对于上一次的增量
        let point = sender.translation(in: blueView)
        let angleX = angle.x + (point.x/30)
        let angleY = angle.y - (point.y/30)
        
        print("point is [\(point.x), \(point.y)]")
        
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        blueView.layer.sublayerTransform = transform //应用到子layer上

        if sender.state == .ended {
            angle.x = angleX
            angle.y = angleY
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

