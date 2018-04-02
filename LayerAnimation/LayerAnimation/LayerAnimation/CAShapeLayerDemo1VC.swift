//
//  CAShapeLayerDemo1VC.swift
//  LayerAnimation
//
//  Created by 王振 on 2018/3/30.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class CAShapeLayerDemo1VC: UIViewController {

    @IBOutlet weak var contentView: LineChartView!
    
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
