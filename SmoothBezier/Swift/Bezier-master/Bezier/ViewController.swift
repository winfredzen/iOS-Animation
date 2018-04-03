//
//  ViewController.swift
//  Bezier
//
//  Created by Ramsundar Shandilya on 10/12/15.
//  Copyright © 2015 Y Media Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var firstBezierView: BezierView!
    
    let dataPoints = [252, 220, 101, 2, 101, 220, 252]
    
    var xAxisPoints : [Double] {
        var points = [Double]()
        for i in 0..<dataPoints.count {
            let val = (Double(i)/6.0) * self.firstBezierView.frame.width.f
            points.append(val)
        }
        
        return points
    }
    
    var yAxisPoints: [Double] {
        var points = [Double]()
        for i in dataPoints {
            let val = (Double(i)/255) * self.firstBezierView.frame.height.f
            points.append(val)
        }
        
        return points
    }
    
    var graphPoints : [CGPoint] {
        var points = [CGPoint]()
        for i in 0..<dataPoints.count {
            let val = CGPoint(x: self.xAxisPoints[i], y: self.yAxisPoints[i])
            points.append(val)
        }
        
        return points
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstBezierView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.firstBezierView.layoutSubviews()
    }
}

extension ViewController: BezierViewDataSource {
    
    func bezierViewDataPoints(bezierView: BezierView) -> [CGPoint] {
        
        //return [CGPoint(x: 40,y: 400),CGPoint(x: 100,y: 250),CGPoint(x: 160,y: 300)]
        
        return graphPoints
    }
}
