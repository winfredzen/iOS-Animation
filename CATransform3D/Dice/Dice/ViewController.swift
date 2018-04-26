//
//  ViewController.swift
//  Dice
//
//  Created by 王振 on 2018/4/17.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let diceView = UIView()
    
    var angle = CGPoint.init(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //viewTransform()
        
        /*
        let subView = UIView.init(frame: blueView.bounds)
        subView.backgroundColor = UIColor.blue
        blueView.addSubview(subView)
        blueView.backgroundColor = UIColor.clear
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTransform(sender:)))
        blueView.addGestureRecognizer(panGesture)
        */
        
        addDice()
        
        // 拖动手势
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewTransform))
        diceView.addGestureRecognizer(panGesture)
        
    }
    
    func addDice() {
        let viewFrame = UIScreen.main.bounds
        
        var diceTransform = CATransform3DIdentity
        
        diceView.frame = CGRect(x: 0, y: viewFrame.maxY / 2 - 50, width: viewFrame.width, height: 100)
        diceView.backgroundColor = UIColor.blue

        // 点数1
        let dice1 = UIImageView.init(image: UIImage(named: "dice1"))
        dice1.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice1.layer.transform = diceTransform
        
        // 点数6
        let dice6 = UIImageView.init(image: UIImage(named: "dice6"))
        dice6.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, -50)
        dice6.layer.transform = diceTransform

        // 点数2
        let dice2 = UIImageView.init(image: UIImage(named: "dice2"))
        dice2.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        // 旋转后平移
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice2.layer.transform = diceTransform
        
        // 点数3
        let dice3 = UIImageView.init(image: UIImage(named: "dice3"))
        dice3.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (-CGFloat.pi / 2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice3.layer.transform = diceTransform

        // 点数4
        let dice4 = UIImageView.init(image: UIImage(named: "dice4"))
        dice4.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 1, 0, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, 50)
        dice4.layer.transform = diceTransform
        
        // 点数5
        let dice5 = UIImageView.init(image: UIImage(named: "dice5"))
        dice5.frame = CGRect(x: viewFrame.maxX / 2 - 50, y: 0, width: 100, height: 100)
        diceTransform = CATransform3DRotate(CATransform3DIdentity, (CGFloat.pi / 2), 0, 1, 0)
        diceTransform = CATransform3DTranslate(diceTransform, 0, 0, -50)
        dice5.layer.transform = diceTransform
        
        
        diceView.addSubview(dice1)
        diceView.addSubview(dice2)
        diceView.addSubview(dice3)
        diceView.addSubview(dice4)
        diceView.addSubview(dice5)
        diceView.addSubview(dice6)
        
        view.addSubview(diceView)
        
    }
    
    @objc func viewTransform(sender: UIPanGestureRecognizer) {
        
        let point = sender.translation(in: diceView)
        let angleX = angle.x + (point.x/30)
        let angleY = angle.y - (point.y/30)
        
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        diceView.layer.sublayerTransform = transform
        
        if sender.state == .ended {
            angle.x = angleX
            angle.y = angleY
        }
    }
    
    
    /*
    func viewTransform() {
        var transform = CATransform3DIdentity
        let angle = CGFloat(45)
        transform.m34 = -1 / 500 // 透视
        blueView.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0)
    }
    */
    
    /*
    @objc func viewTransform(sender: UIPanGestureRecognizer) {
        // translation表示的是持续变化的量，并不是相对于上一次的增量
        let point = sender.translation(in: blueView)
        let angleX = angle.x + (point.x/30)
        let angleY = angle.y - (point.y/30)
        
        print("point is [\(point.x), \(point.y)]")
        
        var transform = CATransform3DIdentity
        transform.m34 = -1 / 500
        transform = CATransform3DRotate(transform, angleX, 0, 1, 0)
        transform = CATransform3DRotate(transform, angleY, 1, 0, 0)
        blueView.layer.sublayerTransform = transform //应用到子layer上

        if sender.state == .ended {
            angle.x = angleX
            angle.y = angleY
        }
        
    }
 */
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

