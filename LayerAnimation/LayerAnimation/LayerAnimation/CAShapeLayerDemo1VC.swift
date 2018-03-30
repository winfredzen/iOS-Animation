//
//  CAShapeLayerDemo1VC.swift
//  LayerAnimation
//
//  Created by 王振 on 2018/3/30.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class CAShapeLayerDemo1VC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    let chartLine: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        layer.fillColor = UIColor.white.cgColor
        layer.lineWidth = 10.0
        //layer.strokeEnd = .0
        return layer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        chartLine.bounds = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        chartLine.position = contentView.center
        contentView.layer.addSublayer(chartLine)
        
        let line:UIBezierPath = UIBezierPath()
        line.lineWidth = 10.0
        line.lineCapStyle = CGLineCap.round
        line.lineJoinStyle = CGLineJoin.round
        line.move(to: CGPoint(x: 0, y: 0))
        line.addLine(to: CGPoint(x: 140, y: 100))
//        line.addLine(to: CGPoint(x: 210, y: 240))
//        line.addLine(to: CGPoint(x: 280, y: 170))
//        line.addLine(to: CGPoint(x: 350, y: 220))
        chartLine.path = line.cgPath
        chartLine.strokeColor = UIColor(red: 77.0/255.0, green: 186.0/255.0, blue: 122.0/255.0, alpha: 1.0).cgColor

        
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
