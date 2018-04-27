# Transtion动画

主要2个方法

```
    @available(iOS 4.0, *)
    open class func transition(with view: UIView, duration: TimeInterval, options: UIViewAnimationOptions = [], animations: (() -> Swift.Void)?, completion: ((Bool) -> Swift.Void)? = nil)

    
    @available(iOS 4.0, *)
    open class func transition(from fromView: UIView, to toView: UIView, duration: TimeInterval, options: UIViewAnimationOptions = [], completion: ((Bool) -> Swift.Void)? = nil)
```


非常不错的文章

+ [iOS UIView Animation - Transition](http://www.devtalking.com/articles/uiview-transition-animation/)
+ [Transitions – UIView Transition (视图转场动画)](https://ios.devdon.com/archives/1207)
+ [Working with UIView’s Transition Animations](http://andrewmarinov.com/working-with-uiviews-transition-animations/)


自己也仿照了一个，效果如下：

![效果](https://github.com/winfredzen/iOS-Animation/blob/master/Transition/images/1.gif)
