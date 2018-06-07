//
//  ViewController.swift
//  TransitionDemo
//
//  Created by 王振 on 2018/6/5.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var animationContainerView: UIView!
    var newView: UIView = UIImageView(image: UIImage(named: "banner"))
    
    var balloonView: UIView = UIImageView(image: UIImage(named: "balloon"))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animationContainerView = UIView(frame: view.bounds)
        view.addSubview(animationContainerView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        newView.center = animationContainerView.center
        balloonView.center = animationContainerView.center
        
        //添加view
        /*
        UIView.transition(with: animationContainerView, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
            self.animationContainerView.addSubview(newView)
        }, completion: nil)
        */
        
        
        //self.animationContainerView.addSubview(self.newView)
        self.animationContainerView.addSubview(self.balloonView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //移除view
        /*
        UIView.transition(with: animationContainerView, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], animations: {
            self.newView.removeFromSuperview()
        }, completion: nil)
        */
        
        /*
        if self.newView.isHidden {
            //隐藏和显示view
            UIView.transition(with: self.newView, duration: 0.33,
                              options: [.curveEaseOut, .transitionFlipFromLeft],
                              animations: {
                                self.newView.isHidden = false
                                },
                              completion: nil)
        }else{
            //隐藏和显示view
            UIView.transition(with: self.newView, duration: 0.33,
                              options: [.curveEaseOut, .transitionFlipFromRight],
                              animations: {
                                self.newView.isHidden = true
                                },
                              completion: nil)
        }
         */
        
        UIView.transition(from: balloonView, to: newView, duration: 0.33, options: [.curveEaseOut, .transitionFlipFromBottom], completion: nil)
    }

}

