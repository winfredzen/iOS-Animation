# UIKit Dynamics

> Apply physics-based animations to your views.
>
> 实现基于物理性质的动画

参考文章：

+ [UIKIT DYNAMICS](https://www.yudiz.com/uikit-dynamics/)
+ [UIKit Dynamics Tutorial: Getting Started](https://www.raywenderlich.com/2326-uikit-dynamics-tutorial-getting-started)

[UIDynamicAnimator](https://developer.apple.com/documentation/uikit/uidynamicanimator):

> An object that provides physics-related capabilities and animations for its dynamic items, and provides the context for those animations.
>
> 相同于一个上下文

[UIDynamicItem](https://developer.apple.com/documentation/uikit/uidynamicitem)一个协议

> Starting in iOS 7, the [`UIView`](https://developer.apple.com/documentation/uikit/uiview) and [`UICollectionViewLayoutAttributes`](https://developer.apple.com/documentation/uikit/uicollectionviewlayoutattributes) classes implement this protocol.
>
> 从iOS7开始，UIView和UICollectionViewLayoutAttributes实现了该协议

一些常用方法：

```swift
init(referenceView view: UIView)			// To initialize animator
addBehavior(_ behavior: UIDynamicBehavior)	// To add a behavior
removeBehavior(_ behavior: UIDynamicBehavior)	// To remove particular behavior
removeAllBehaviors()
```



## UIGravityBehavior

[UIGravityBehavior](https://developer.apple.com/documentation/uikit/uigravitybehavior)定义如下：

```swift
class UIGravityBehavior : UIDynamicBehavior
```

+ [`gravityDirection`](https://developer.apple.com/documentation/uikit/uigravitybehavior/1620423-gravitydirection)设置重力的方向，默认是(`0.0`, `1.0`)，1表示的是1000 points / second²的加速度
+ 也可以单独设置[`magnitude`](https://developer.apple.com/documentation/uikit/uigravitybehavior/1620418-magnitude)和[`angle`](https://developer.apple.com/documentation/uikit/uigravitybehavior/1620417-angle)

如下的例子，定义如下的view：

```swift
let view = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
view.backgroundColor = UIColor.lightText
PlaygroundPage.current.liveView = view

let whiteSquare = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
whiteSquare.backgroundColor = UIColor.white
view.addSubview(whiteSquare)

let orangeSquare = UIView(frame: CGRect(x: 400, y: 100, width: 100, height: 100))
orangeSquare.backgroundColor = UIColor.orange
view.addSubview(orangeSquare)
```

创建animator需要一个referenceView，如下：

```swift
let animator = UIDynamicAnimator(referenceView: view)
```

给orangeSquare添加重力行为

```swift
animator.addBehavior(UIGravityBehavior(items: [orangeSquare]))
```



