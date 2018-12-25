# UIKit Dynamics

> Apply physics-based animations to your views.
>
> 实现基于物理性质的动画

参考文章：

+ [UIKIT DYNAMICS](https://www.yudiz.com/uikit-dynamics/)
+ [UIKit Dynamics Tutorial: Getting Started](https://www.raywenderlich.com/2326-uikit-dynamics-tutorial-getting-started)
+ [UIKit Dynamics Tutorial](https://www.raywenderlich.com/2650-uikit-dynamics-tutorial)

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

[UIDynamicItemBehavior](https://developer.apple.com/documentation/uikit/uidynamicitembehavior):

> A base dynamic animation configuration for one or more dynamic items.



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

效果如下：

![重力动画](https://github.com/winfredzen/iOS-Animation/blob/master/images/001.gif)

可以看见orangeSquare加速下落，超出了view的边界



## UICollisionBehavior

[UICollisionBehavior](https://developer.apple.com/documentation/uikit/uicollisionbehavior)表示碰撞，如下的例子：

```swift
let boundaryCollision = UICollisionBehavior(items: [whiteSquare, orangeSquare])
boundaryCollision.translatesReferenceBoundsIntoBoundary = true
animator.addBehavior(boundaryCollision)

let bounce = UIDynamicItemBehavior(items: [orangeSquare])
bounce.elasticity = 0.6 //弹性
bounce.density = 200 //密度
bounce.resistance = 2 //阻抗
animator.addBehavior(bounce)

//打开调试
animator.setValue(true, forKey: "debugEnabled")
```

`translatesReferenceBoundsIntoBoundary`设置为true，表示使referenceView的border成为另一个边界

![重力动画](https://github.com/winfredzen/iOS-Animation/blob/master/images/002.gif)



## UIFieldBehavior

[UIFieldBehavior](https://developer.apple.com/documentation/uikit/uifieldbehavior)我的理解是类似于一种场域，参考：

+ [Dynamic animations: UIFieldBehavior](https://www.invasivecode.com/weblog/dynamic-animation-uifieldbehavior)
+ [UIFieldBehavior](https://nshipster.com/uifieldbehavior/)

如下的代码，演示了compound behaviors，可以使你的behaviors更复杂

```swift
let parentBehavior = UIDynamicBehavior()
let viewBehavior = UIDynamicItemBehavior(items: [whiteSquare])
viewBehavior.density = 0.01
viewBehavior.resistance = 10
viewBehavior.friction = 0.0 //摩擦
viewBehavior.allowsRotation = false
parentBehavior.addChildBehavior(viewBehavior)

let fieldBehavior = UIFieldBehavior.springField()
fieldBehavior.addItem(whiteSquare)
fieldBehavior.position = CGPoint(x: 150, y: 350)
fieldBehavior.region = UIRegion(size: CGSize(width: 500, height: 500))
parentBehavior.addChildBehavior(fieldBehavior)

animator.addBehavior(parentBehavior)

let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
DispatchQueue.main.asyncAfter(deadline: delayTime) {
  let pushBehavior = UIPushBehavior(items: [whiteSquare], mode: .instantaneous)
  pushBehavior.pushDirection = CGVector(dx: 0, dy: -1)
  pushBehavior.magnitude = 0.3
  animator.addBehavior(pushBehavior)
}

let attachment = UIAttachmentBehavior(item: orangeSquare, attachedToAnchor: CGPoint(x: 300, y: 100))
attachment.length = 300
animator.addBehavior(attachment)
```

![复合动画](https://github.com/winfredzen/iOS-Animation/blob/master/images/003.gif)



## UISnapBehavior

可参考：

+ [UIKit Dynamics in the real world](https://medium.com/@raulriera/uikit-dynamics-in-the-real-world-ef0dfd924260)

![UISnapBehavior](https://cdn-images-1.medium.com/max/800/1*UdZ9LSJ-nwdIQ0s-FJppNw.gif)



