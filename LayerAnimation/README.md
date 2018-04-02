# Layer动画

## 粒子动画

粒子动画涉及到2个类：`CAEmitterCell`和`CAEmitterLayer`


`CAEmitterLayer`表示粒子发射的图层，主要控制粒子展现范围、粒子发射位置、粒子发射形状、渲染模式等

`CAEmitterCell`表示粒子发射单元，用于对粒子做更精细的控制。控制粒子的移动速度、方向、范围等，一些重要属性的介绍：

+ birthRate-每秒粒子的个数
+ lifetime-粒子消失前经过的时间
+ lifetimeRange-可使用此属性来修改粒子的lifetime，系统会给每个粒子一个随机的lifetime，范围在`(lifetime – lifetimeRange, lifetime + lifetimeRange)`之间
+ color-应用于contents的颜色
+ contents-通常是CGImage
+ name-可设置一个name，可用于在以后修改其属性
+ velocity-粒子的速度，设置后粒子朝屏幕的右边发射
+ velocityRange-粒子的速度的变化范围，于lifetimeRange类似
+ emissionRange-粒子发射的角度范围，为一个锥形
+ scaleSpeed-每秒粒子缩放的速度
+ spin-每个粒子旋转的速度

入门教程推荐：

+ [UIKit Particle Systems in iOS 5 Tutorial](https://www.raywenderlich.com/6063/uikit-particle-systems-in-ios-5-tutorial)
+ [Emitter Layers 发射极层](http://www.cnblogs.com/YungMing/p/4032635.html)

可实现如飘雪、礼花、烟火等效果，如下面的文章介绍的有：

+ [Smooth Core Animation Snow Effect](https://medium.com/@satindersingh71/smooth-core-animation-snow-effect-3d93417b96b3)
+ [Particle effects in swift using CAEmitterLayer](http://prabhu.xyz/2017/05/08/particle-effects-in-swift-using-caemitterlayer.html)
+ [Tutorial: Particle Systems in Core Animation with CAEmitterLayer](http://www.enharmonichq.com/tutorial-particle-systems-in-core-animation-with-caemitterlayer/)
+ [iOS 动画 —— 礼花效果](https://www.jianshu.com/p/08cbe521afe5)
+ [Apple实例代码Fireworks](https://developer.apple.com/library/content/samplecode/Fireworks/Introduction/Intro.html#//apple_ref/doc/uid/DTS40009114)


如下的霓虹效果：

![霓虹效果](https://github.com/winfredzen/iOS-Animation/blob/master/LayerAnimation/screenshot/CAEmitterLayer_Animation_1.gif)


## CAGradientLayer渐变动画

如下的类似于光波扫描的动画，是对`CAGradientLayer`做动画效果来实现：

![光波扫描的动画](https://github.com/winfredzen/iOS-Animation/blob/master/LayerAnimation/screenshot/CAGradientLayer_Animation_1.gif)


## CAShapeLayer动画

如下的折线图和柱状图：

![折线图](https://github.com/winfredzen/iOS-Animation/blob/master/LayerAnimation/screenshot/CAShapeLayer_Animation_1.gif)

![柱状图](https://github.com/winfredzen/iOS-Animation/blob/master/LayerAnimation/screenshot/CAShapeLayer_Animation_2.gif)













