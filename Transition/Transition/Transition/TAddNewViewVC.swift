//
//  TAddNewViewVCViewController.swift
//  Transition
//
//  Created by 王振 on 2018/4/27.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class TAddNewViewVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerView1: UIView!
    @IBOutlet weak var containerView2: UIView!
    @IBOutlet weak var containerView3: UIView!
    
    let view1 = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 150, height: 150))
    let view2 = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 150, height: 150))
    let view3 = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
    
    let view4 = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 334, height: 72))
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
        view1.image = UIImage(named: "001-bee")
        view2.image = UIImage(named: "003-bamboo")
        view3.image = UIImage(named: "002-whale")
        view4.image = UIImage(named: "005-winner")
        
        
        delay(0) {
            UIView.transition(with: self.containerView1, duration: 1.5, options: [.curveEaseInOut, .transitionFlipFromBottom], animations: {
                self.containerView1.addSubview(self.view1)
            }, completion: nil)
        }

        delay(1.0) {
            UIView.transition(with: self.containerView2, duration: 1.5, options: [.curveEaseInOut, .transitionFlipFromLeft], animations: {
                self.containerView2.addSubview(self.view2)
            }, completion: nil)
        }
        
        delay(1.5) {
            UIView.transition(with: self.containerView3, duration: 1.5, options: [.curveEaseInOut, .transitionFlipFromRight], animations: {
                self.containerView3.addSubview(self.view3)
            }, completion: nil)
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // 对于自动布局的view 放在viewDidAppear中才有效
    override func viewDidAppear(_ animated: Bool) {
        /*
        UIView.transition(with: self.containerView, duration: 1.5, options: .transitionFlipFromLeft, animations: {
            self.containerView.addSubview(self.view1)
            self.view.layoutIfNeeded()
        }, completion: nil)
         */
    }
    
    func delay(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }

    @IBAction func goAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.containerView.backgroundColor = UIColor(red: 252.0/255.0, green: 155.0/255.0, blue: 65.0/255.0, alpha: 1)
            
        }, completion: nil)
        
        UIView.transition(with: self.containerView3, duration: 0.5, options: [.curveEaseInOut, .transitionFlipFromTop], animations: {
            self.view3.removeFromSuperview()
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.view1.frame = CGRect.init(x: 0, y: 0, width: 334, height: 72)
            self.containerView1.frame = CGRect.init(x: 20, y: 20, width: 334, height: 72)
        }, completion: {
            (flag: Bool) in
            if flag {
                UIView.transition(from: self.view1, to: self.view4, duration: 1.0, options: .transitionCrossDissolve, completion: { (complete) in
                    
                })
            }
        })
        
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
