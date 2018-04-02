//
//  BarChartView.swift
//  LayerAnimation
//
//  Created by 王振 on 2018/4/2.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class BarChartView: UIView {

    var chartLine:CAShapeLayer = CAShapeLayer()
    var pathAnimation:CABasicAnimation = CABasicAnimation()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initSetting()
    }
    
    func initSetting() {
        
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        chartLine.lineCap = kCALineCapSquare
        chartLine.lineJoin = kCALineJoinRound
        chartLine.fillColor = UIColor.gray.cgColor
        chartLine.lineWidth = 30.0
        chartLine.strokeEnd = 0.0
        self.layer.addSublayer(chartLine)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder)
        
        initSetting()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        chartLine.strokeEnd = 1.0
        chartLine.add(pathAnimation, forKey: nil)
    }

    override func draw(_ rect: CGRect) {
        let line:UIBezierPath = UIBezierPath()
        line.lineWidth = 30.0
        line.lineCapStyle = CGLineCap.square
        line.lineJoinStyle = CGLineJoin.round
        for i in 0...4 {
            let x:CGFloat = CGFloat(20+60*i)
            let y:CGFloat = CGFloat(100+20*i)
            line.move(to: CGPoint(x: x, y: 215))
            line.addLine(to: CGPoint(x: x, y: y))
        }
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
