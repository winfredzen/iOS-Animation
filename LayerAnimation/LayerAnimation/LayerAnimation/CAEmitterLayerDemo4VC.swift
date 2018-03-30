//
//  CAEmitterLayerDemo4VC.swift
//  LayerAnimation
//
//  Created by 王振 on 2018/3/30.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class CAEmitterLayerDemo4VC: UIViewController {

    let fireEmitter = CAEmitterLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.gray
        
        fireEmitter.frame = self.view.bounds
        fireEmitter.emitterPosition = CGPoint(x: 50, y: 50 + 64)
        fireEmitter.emitterSize =  CGSize(width: 10, height: 10)
        self.view.layer.addSublayer(fireEmitter)
        
        let fire = CAEmitterCell()
        fire.birthRate = 200
        fire.lifetime = 3.0
        fire.lifetimeRange = 0.5
        fire.color = UIColor(red: 0.8, green: 0.4, blue: 0.2, alpha: 0.1).cgColor
        fire.contents = UIImage(named: "Particles_fire")?.cgImage
        fire.name = "fire"
        
        fire.velocity = 10
        fire.velocityRange = 20
        fire.emissionRange = CGFloat(Double.pi / 2)
        
        fire.scaleSpeed = 0.3
        fire.spin = 0.5
        
        fire.birthRate = 200;
        
        fireEmitter.renderMode = kCAEmitterLayerAdditive
       
        fireEmitter.emitterCells = [fire]
        
        
    }
    
    func setEmitterPositionFromTouch(touch: UITouch) {
        fireEmitter.emitterPosition = touch.location(in: self.view)
    }
    
    func setIsEmitting(isEmitting: Bool) {
        fireEmitter.setValue(NSNumber.init(value: isEmitting ? 200 : 0), forKey: "emitterCells.fire.birthRate")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as! UITouch
        setEmitterPositionFromTouch(touch: touch)
        setIsEmitting(isEmitting: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        setIsEmitting(isEmitting: false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setIsEmitting(isEmitting: false)
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
