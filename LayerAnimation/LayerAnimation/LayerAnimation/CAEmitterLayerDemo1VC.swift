//
//  CAEmitterLayerDemo1VC.swift
//  LayerAnimation
//
//  Created by 王振 on 2018/3/30.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class CAEmitterLayerDemo1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //demo1()
        //demo2()
        //demo3()
        //demo4()
        //demo5()
        demo6()
        //demo7()
    }
    
    
    func demo1(){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 10, height: 10), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 10, height: 10))
        context?.setFillColor(UIColor.gray.cgColor)
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cell = CAEmitterCell()
        cell.contents = image?.cgImage
        cell.birthRate = 1
        cell.lifetime = 2
        cell.velocity = 100
        
        
        
        let emit = CAEmitterLayer()
        emit.frame = self.view.bounds
        emit.backgroundColor = UIColor.green.cgColor
        emit.emitterPosition = self.view.center
        emit.emitterShape = kCAEmitterLayerPoint
        emit.emitterMode = kCAEmitterLayerPoints
        emit.emitterCells = [cell]
        
        self.view.layer.addSublayer(emit)
    }
    
    func demo2(){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 10, height: 10), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 10, height: 10))
        context?.setFillColor(UIColor.gray.cgColor)
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cell = CAEmitterCell()
        cell.contents = image?.cgImage
        cell.birthRate = 100
        cell.lifetime = 1.5
        cell.velocity = 100
        cell.emissionRange = CGFloat(Double.pi / 5.0)
        
        
        let emit = CAEmitterLayer()
        emit.frame = self.view.bounds
        emit.backgroundColor = UIColor.green.cgColor
        emit.emitterPosition = self.view.center
        emit.emitterShape = kCAEmitterLayerPoint
        emit.emitterMode = kCAEmitterLayerPoints
        emit.emitterCells = [cell]
        
        self.view.layer.addSublayer(emit)
    }

    
    func demo3(){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 10, height: 10), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 10, height: 10))
        context?.setFillColor(UIColor.gray.cgColor)
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cell = CAEmitterCell()
        cell.contents = image?.cgImage
        cell.birthRate = 100
        cell.lifetime = 1.5
        cell.velocity = 100
        cell.emissionRange = CGFloat(Double.pi / 5.0)
        
        cell.xAcceleration = -40
        cell.yAcceleration = 200
        
        
        let emit = CAEmitterLayer()
        emit.frame = self.view.bounds
        emit.backgroundColor = UIColor.green.cgColor
        emit.emitterPosition = self.view.center
        emit.emitterShape = kCAEmitterLayerPoint
        emit.emitterMode = kCAEmitterLayerPoints
        emit.emitterCells = [cell]
        
        self.view.layer.addSublayer(emit)
    }

    func demo4(){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 10, height: 10), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 10, height: 10))
        context?.setFillColor(UIColor.gray.cgColor)
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cell = CAEmitterCell()
        cell.contents = image?.cgImage
        cell.birthRate = 100
        cell.lifetime = 1.5
        cell.velocity = 100
        cell.emissionRange = CGFloat(Double.pi / 5.0)
        
        cell.xAcceleration = -40
        cell.yAcceleration = 200
        
        cell.lifetimeRange = 0.4
        cell.velocityRange = 20
        cell.scaleRange = 0.2
        cell.scaleSpeed = 0.2
        cell.color = UIColor.blue.cgColor
        cell.greenRange = 0.5
        cell.greenSpeed = 0.75
        
        let emit = CAEmitterLayer()
        emit.frame = self.view.bounds
        emit.backgroundColor = UIColor.green.cgColor
        emit.emitterPosition = self.view.center
        emit.emitterShape = kCAEmitterLayerPoint
        emit.emitterMode = kCAEmitterLayerPoints
        emit.emitterCells = [cell]
        
        self.view.layer.addSublayer(emit)
    }
    
    func demo5(){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 10, height: 10), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 10, height: 10))
        context?.setFillColor(UIColor.gray.cgColor)
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cell = CAEmitterCell()
        cell.contents = image?.cgImage
        cell.birthRate = 100
        cell.lifetime = 1.5
        cell.velocity = 100
        cell.emissionRange = CGFloat(Double.pi / 5.0)
        
        cell.xAcceleration = -40
        cell.yAcceleration = 200
        
        cell.lifetimeRange = 0.4
        cell.velocityRange = 20
        cell.scaleRange = 0.2
        cell.scaleSpeed = 0.2
        cell.color = UIColor.blue.cgColor
        cell.greenRange = 0.5
        cell.greenSpeed = 0.75
        
        cell.name = "circle"
        
        let emit = CAEmitterLayer()
        emit.frame = self.view.bounds
        emit.backgroundColor = UIColor.green.cgColor
        emit.emitterPosition = self.view.center
        emit.emitterShape = kCAEmitterLayerPoint
        emit.emitterMode = kCAEmitterLayerPoints
        emit.emitterCells = [cell]
        
        let key = "emitterCells.circle.greenSpeed"
        let ba = CABasicAnimation(keyPath: key)
        ba.fromValue = -1.0
        ba.toValue = 3.0
        ba.duration = 4
        ba.autoreverses = true
        ba.repeatCount = HUGE
        emit.add(ba, forKey: nil)
        
        self.view.layer.addSublayer(emit)
    }
    
    func demo6(){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 10, height: 10), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 10, height: 10))
        context?.setFillColor(UIColor.gray.cgColor)
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cell = CAEmitterCell()
        cell.contents = image?.cgImage
        cell.birthRate = 100
        cell.lifetime = 1.5
        cell.velocity = 100
        cell.emissionRange = CGFloat(Double.pi / 5.0)
        
        cell.xAcceleration = -40
        cell.yAcceleration = 200
        
        cell.lifetimeRange = 0.4
        cell.velocityRange = 20
        cell.scaleRange = 0.2
        cell.scaleSpeed = 0.2
        cell.color = UIColor.blue.cgColor
        cell.greenRange = 0.5
        cell.greenSpeed = 0.75
        
        cell.name = "circle"
        
        
        let cell2 = CAEmitterCell()
        cell.emitterCells = [cell2]
        cell2.contents = image?.cgImage
        cell2.emissionRange = CGFloat(Double.pi)
        cell2.birthRate = 200
        cell2.lifetime = 0.4
        cell2.velocity = 200
        cell2.scale = 0.2
        cell2.beginTime = 1.4
        cell2.duration = 0.8
        
        
        let emit = CAEmitterLayer()
        emit.frame = self.view.bounds
        emit.backgroundColor = UIColor.green.cgColor
        emit.emitterPosition = self.view.center
        emit.emitterShape = kCAEmitterLayerPoint
        emit.emitterMode = kCAEmitterLayerPoints
        emit.emitterCells = [cell]
        
        let key = "emitterCells.circle.greenSpeed"
        let ba = CABasicAnimation(keyPath: key)
        ba.fromValue = -1.0
        ba.toValue = 3.0
        ba.duration = 4
        ba.autoreverses = true
        ba.repeatCount = HUGE
        emit.add(ba, forKey: nil)
        
        self.view.layer.addSublayer(emit)
    }
    
    func demo7(){
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 10, height: 10), false, 1)
        let context = UIGraphicsGetCurrentContext()
        context?.addEllipse(in: CGRect(x: 0, y: 0, width: 10, height: 10))
        context?.setFillColor(UIColor.gray.cgColor)
        context?.fillPath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cell = CAEmitterCell()
        cell.contents = image?.cgImage
        cell.birthRate = 100
        cell.lifetime = 1.5
        cell.velocity = 100
        cell.emissionRange = CGFloat( 3 * Double.pi / 4.0)
        
        cell.xAcceleration = -40
        cell.yAcceleration = 200
        
        cell.lifetimeRange = 0.4
        cell.velocityRange = 20
        cell.scaleRange = 0.2
        cell.scaleSpeed = 0.2
        cell.color = UIColor.blue.cgColor
        cell.greenRange = 0.5
        cell.greenSpeed = 0.75
        
        cell.name = "circle"
        
        
        let cell2 = CAEmitterCell()
        cell.emitterCells = [cell2]
        cell2.contents = image?.cgImage
        cell2.emissionRange = CGFloat(Double.pi)
        cell2.birthRate = 200
        cell2.lifetime = 0.4
        cell2.velocity = 200
        cell2.scale = 0.2
        cell2.beginTime = 1.4
        cell2.duration = 0.8
        
        
        let emit = CAEmitterLayer()
        emit.frame = self.view.bounds
        emit.backgroundColor = UIColor.green.cgColor
        emit.emitterPosition = self.view.center
        emit.emitterSize = CGSize(width: 100, height: 100)
        emit.emitterShape = kCAEmitterLayerCircle
        emit.emitterMode = kCAEmitterLayerOutline
        emit.emitterCells = [cell]
        
        let key = "emitterCells.circle.greenSpeed"
        let ba = CABasicAnimation(keyPath: key)
        ba.fromValue = -1.0
        ba.toValue = 3.0
        ba.duration = 4
        ba.autoreverses = true
        ba.repeatCount = HUGE
        emit.add(ba, forKey: nil)
        
        self.view.layer.addSublayer(emit)
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
