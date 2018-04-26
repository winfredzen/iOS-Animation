//
//  ViewController.swift
//  CATransitionDemo
//
//  Created by 王振 on 2018/4/26.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var transitionPicker: UIPickerView!
    @IBOutlet var imageView: UIImageView!
    
    var imageName = "imageA.jpg"
    
    //Class Variables
    var transitions = ["fade", "push", "reveal", "moveIn","pageCurl", "pageUnCurl", "cube", "oglFlip", "suckEffect","rippleEffect", "cameraIris", "cameraIrisHollowOpen", "cameraIrisHollowClose"]
    var directions = [kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom]
    var durations = [0.0, 0.15, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 4.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.transitionPicker.delegate = self
        self.transitionPicker.dataSource = self
        
        self.transitionPicker.selectRow(durations.count / 2, inComponent: 2, animated: true)
        
    }

    @IBAction func viewTransitionAction(_ sender: Any) {
        // transition
        let animation = CATransition()
        
        // 设置属性
        animation.type = transitions[transitionPicker.selectedRow(inComponent: 0)]
        animation.subtype = directions[transitionPicker.selectedRow(inComponent: 1)]
        animation.duration = durations[transitionPicker.selectedRow(inComponent: 2)]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        // 切换图片
        if(self.imageName == "imageA.jpg"){
            self.imageView.image = UIImage(named: "imageB.jpg");
            self.imageName = "imageB.jpg";
        }
        else{
            self.imageView.image = UIImage(named: "imageA.jpg");
            self.imageName = "imageA.jpg";
        }
        
        // 添加annimation
        self.imageView.layer.add(animation, forKey: "animation");
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return transitions.count
        case 1:
            return directions.count
        case 2:
            return durations.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return transitions[row]
        case 1:
            return directions[row]
        case 2:
            return String(durations[row]) + "s"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.view.layoutIfNeeded()
    }
}













