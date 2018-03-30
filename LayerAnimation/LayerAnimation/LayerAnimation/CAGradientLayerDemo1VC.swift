//
//  CAGradientLayerDemo1VC.swift
//  LayerAnimation
//
//  Created by 王振 on 2018/3/30.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class CAGradientLayerDemo1VC: UIViewController {

    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        demo1()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func demo1() {
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        gradientLayer.position = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        gradientLayer.backgroundColor = UIColor.orange.cgColor
        
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.white.cgColor,UIColor.clear.cgColor]
        gradientLayer.locations = [0.0,0.0,1.0]
        
        self.view.layer.addSublayer(gradientLayer)
        
        let gradientAnimation:CABasicAnimation = CABasicAnimation()
        gradientAnimation.keyPath = "locations"
        gradientAnimation.fromValue = [0.0,0.0,1.0]
        gradientAnimation.toValue = [0.0,1.0,1.0]
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = HUGE
        gradientLayer.add(gradientAnimation, forKey: nil)
        
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
