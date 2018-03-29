//
//  CAReplicatorLayerDemo1VC.swift
//  LayerAnimation
//
//  Created by 王振 on 2018/3/29.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class CAReplicatorLayerDemoVC: UIViewController {
    
    @IBOutlet weak var replicatorAnimationView: UIView!
    @IBOutlet weak var activityIndicatorView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        firstReplicatorAnimation()
        
        activityIndicatorAnimation()
        
    }
    
    func firstReplicatorAnimation() {
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: replicatorAnimationView.frame.origin.x, y: replicatorAnimationView.frame.origin.y, width: replicatorAnimationView.frame.size.width, height: replicatorAnimationView.frame.size.height)
        replicatorLayer.anchorPoint = CGPoint(x: 0, y: 0)
        replicatorLayer.backgroundColor = UIColor.clear.cgColor
        replicatorAnimationView.layer.addSublayer(replicatorLayer)
        
        
        let rectangle = CALayer()
        rectangle.bounds = CGRect(x: 0, y: 0, width: 30, height: 90)
        rectangle.anchorPoint = CGPoint(x: 0, y: 0)
        rectangle.position = CGPoint(x: replicatorAnimationView.frame.origin.x + 10, y: replicatorAnimationView.frame.origin.y + 150)
        rectangle.cornerRadius = 2
        rectangle.backgroundColor = UIColor.white.cgColor
        replicatorLayer.addSublayer(rectangle)
        
        
        let moveRectangle = CABasicAnimation(keyPath: "position.y")
        moveRectangle.toValue = rectangle.position.y - 80
        moveRectangle.duration = 0.7
        moveRectangle.autoreverses = true
        moveRectangle.repeatCount = HUGE
        rectangle.add(moveRectangle, forKey: nil)
        
        replicatorLayer.instanceCount = 3
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(40, 0, 0)
        replicatorLayer.instanceDelay = 0.3

        replicatorLayer.masksToBounds = true

        
    }
    
    func activityIndicatorAnimation() {
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.bounds = CGRect(x: 0, y: 0, width: activityIndicatorView.frame.size.width, height: activityIndicatorView.frame.size.height)
        replicatorLayer.position = CGPoint(x: activityIndicatorView.frame.size.width/2, y: activityIndicatorView.frame.size.height/2)
        replicatorLayer.backgroundColor = UIColor.clear.cgColor
        activityIndicatorView.layer.addSublayer(replicatorLayer)
        
        
        let circle = CALayer()
        circle.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
        circle.position = CGPoint(x: activityIndicatorView.frame.size.width/2, y: activityIndicatorView.frame.size.height/2 - 55)
        circle.cornerRadius = 7.5
        circle.backgroundColor = UIColor.white.cgColor
        replicatorLayer.addSublayer(circle)
        
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1
        scale.toValue = 0.1
        scale.duration = 1
        scale.repeatCount = HUGE
        circle.add(scale, forKey: nil)
        
        
        replicatorLayer.instanceCount = 15
        let angle = CGFloat(2 * Double.pi) / CGFloat(15)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        replicatorLayer.instanceDelay = 1/15
        
        

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
