//
//  TFromToVC.swift
//  Transition
//
//  Created by 王振 on 2018/4/27.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class TFromToVC: UIViewController {

    let coinContainer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 300))
    let upView = UIImageView.init(frame: CGRect.init(x: 50, y: 50, width: 200, height: 200))
    let downView = UIImageView.init(frame: CGRect.init(x: 50, y: 50, width: 200, height: 200))
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(coinContainer)
        coinContainer.backgroundColor = UIColor.orange
        coinContainer.center = self.view.center
        
        self.coinContainer.addSubview(upView)
        upView.backgroundColor = UIColor.white
        upView.image = UIImage(named: "005-mushroom")
        
        downView.backgroundColor = UIColor.blue
        downView.image = UIImage(named: "004-flower")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if flag {
            
            UIView.transition(from: self.upView, to: self.downView, duration: 0.5, options: .transitionFlipFromLeft, completion: nil)
            
        }else{
            
            UIView.transition(from: self.downView, to: self.upView, duration: 0.5, options: .transitionFlipFromLeft, completion: nil)
            
        }
        
        flag = !flag
        
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
