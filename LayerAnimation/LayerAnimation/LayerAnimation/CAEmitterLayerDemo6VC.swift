//
//  CAEmitterLayerDemo6VC.swift
//  LayerAnimation
//
//  Created by 王振 on 2018/3/30.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class CAEmitterLayerDemo6VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.black
        
        let emitterCell = CAEmitterCell()
        
        emitterCell.name = "nenolight"
        emitterCell.emissionLongitude  = CGFloat(M_PI*2)// emissionLongitude:x-y 平面的 发 射方向
        emitterCell.velocity = 50// 粒子速度
        emitterCell.velocityRange = 50// 粒子速度范围
        emitterCell.scaleSpeed = -0.2// 缩放比例 超大火苗
        emitterCell.scale = 0.1
        emitterCell.greenSpeed = -0.1
        emitterCell.redSpeed = -0.2
        emitterCell.blueSpeed = 0.1
        emitterCell.alphaSpeed = -0.2
        emitterCell.birthRate = 100
        emitterCell.lifetime = 4
        emitterCell.color = UIColor.white.cgColor
        emitterCell.contents = UIImage(named: "neonlight.png")!.cgImage
        
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.position = self.view.center// 粒子发射位置
        emitterLayer.emitterSize = CGSize(width: 2, height: 2)// 控制粒子大小
        emitterLayer.renderMode = kCAEmitterLayerBackToFront
        emitterLayer.emitterMode = kCAEmitterLayerOutline// 控制发射源模式 即形状
        emitterLayer.emitterShape = kCAEmitterLayerCircle
        
        emitterLayer.emitterCells = [emitterCell]
        
        self.view.layer.addSublayer(emitterLayer)
        
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
