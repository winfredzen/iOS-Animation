# 显示层动画

动画过程包括动画起始阶段、动画进行阶段、动画结束阶段

如果是在`UIViewController`中进行动画，可将动画起始阶段放在`viewDidLoad()`，将动画的进行阶段放在`viewWillAppear(_ animated: Bool)`中

可以通过闭包的形式来进行动画，如：

```
animate(withDuration duration: TimeInterval, animations: @escaping () -> Swift.Void) 
```

也可以使用commit形式的提交动画，如：

```
UIView.beginAnimations(nil, context: nil)//动画开始
UIView.setAnimationDuration(1)//动画周期设置
loginButton!.frame = CGRect(x:20,y:loginButton!.frame.origin.y,width:loginButton!.frame.width,height:loginButton!.frame.height)//动画位置设置
UIView.commitAnimations()//动画提交
```

常见的动画属性：

1.位置属性：frame、bounds、center

2.透明度属性：alpha

3.Layer属性：圆角渐变、边框颜色、阴影、3D等



## 显示层关键帧动画

参考：

+ [Chaining UIView animations with animateKeyframes](https://medium.com/the-aesthetic-programmer/chaining-uiview-animations-with-animatekeyframes-466b5eaf9568)
+ [iOS – Learn to Properly chain UIView animations with animateKeyframes](https://equaleyes.com/blog/2017/12/21/ios-learn-to-properly-chain-uiview-animations-with-animatekeyframes/)
+ [iOS UIView Animation - Keyframe](http://www.devtalking.com/articles/uiview-keyframe-animation/)



在iOS7中引入了

```
@available(iOS 7.0, *)
open class func animateKeyframes(withDuration duration: TimeInterval, delay: TimeInterval, options: UIViewKeyframeAnimationOptions = [], animations: @escaping () -> Swift.Void, completion: ((Bool) -> Swift.Void)? = nil)
```

参数的含义，与原来动画的参数大致相同，options常用的值包括：

+ calculationModeLinear
+ calculationModeDiscrete
+ calculationModePaced
+ calculationModeCubic
+ calculationModeCubicPaced

使用此方法，可以实现链式动画。原来在一个动画完成后，再启动另一个动画时，我们可能会把后一个动画放在`completion`回调中

如下的效果：



实现过程是这样的：

```
        UIView.animate(withDuration: 0.5, animations: {
            self.circleView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (completed) in
            UIView.animate(withDuration: 0.5, animations: {
                self.circleView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            }, completion: { (completed) in
                UIView.animate(withDuration: 1, animations: {
                    self.circleView.frame.origin.x -= 50
                }, completion: { (completed) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.circleView.frame.origin.x += 150
                    }, completion: { (completed) in
                        
                    })
                })
            })
        }
```

一层套一层，是不是很麻烦？

可使用`animateKeyframes(…)`来实现，如下：

```
        //总时间是2.5秒
        UIView.animateKeyframes(withDuration: 2.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.2, animations: {
                self.circleView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {
                self.circleView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4, animations: {
                self.circleView.frame.origin.x -= 50
            })
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                self.circleView.frame.origin.x += 150
            })
            
        }) { (completed) in
            //Completion of whole animation sequence
        }
```

注意`addKeyframe`的参数`frameStartTime`、`relativeDuration`都是相对值，范围是0到1之间

> For example, if you set the sequence duration to 2.0 seconds and the relative start time of some animation to 0.5, the animation will start 1.0 second after the animation sequence starts animating.

















