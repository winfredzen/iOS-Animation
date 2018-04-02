//
//  LineChartView.swift
//  LayerAnimation
//
//  Created by 王振 on 2018/4/2.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

let PNGreen:UIColor = UIColor(red: 77.0/255.0, green: 186.0/255.0, blue: 122.0/255.0, alpha: 1.0)

class LineChartView: UIView {
    
    let chartLine: CAShapeLayer = CAShapeLayer()
    let pathAnimation: CABasicAnimation = CABasicAnimation()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
        initSetting()
    }
    
    func initSetting() {
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        chartLine.lineCap = kCALineCapRound
        chartLine.lineJoin = kCALineJoinRound
        chartLine.fillColor = UIColor.white.cgColor
        chartLine.lineWidth = 10.0
        chartLine.strokeEnd = 0.0
        self.layer.addSublayer(chartLine)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        chartLine.strokeEnd = 1.0
        chartLine.add(pathAnimation, forKey: nil)
        
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        let line:UIBezierPath = UIBezierPath()
        line.lineWidth = 10.0
        line.lineCapStyle = CGLineCap.round
        line.lineJoinStyle = CGLineJoin.round
        line.move(to: CGPoint(x: 10, y: 260))
        line.addLine(to: CGPoint(x: 80, y: 100))
        line.addLine(to: CGPoint(x: 150, y: 240))
        line.addLine(to: CGPoint(x: 210, y: 170))
        line.addLine(to: CGPoint(x: 280, y: 220))
        chartLine.path = line.cgPath
        chartLine.strokeColor = PNGreen.cgColor
        
        pathAnimation.keyPath = "strokeEnd"
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.autoreverses = false
        pathAnimation.duration = 2.0
        
        
    }
    
    
}
