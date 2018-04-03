//
//  WaveView.m
//  WaveAnimation
//
//  Created by 王振 on 2018/4/3.
//  Copyright © 2018年 wz. All rights reserved.
//

#import "WaveView.h"

@interface WaveView ()

@property (nonatomic, assign) CGFloat waterWaveHeight;

@property (nonatomic, assign) CGFloat zoomY;

@property (nonatomic, assign) CGFloat flag;

@property (nonatomic, assign) CGFloat translateX;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end


@implementation WaveView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initConfig];
        
        [self startDisplayLink];
    }
    return self;
}

- (void)initConfig
{
    _waterWaveHeight = 150;
    _zoomY = 1;
    _translateX = 20;
    _flag = NO;
    
    [self addWaveGradientLayer];
    
    [self addWaveShapeLayer];
    
}

- (void)startDisplayLink
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)handleDisplayLink:(CADisplayLink *)displayLink
{
    self.translateX += 0.1;
    if (!self.flag)
    {
        self.zoomY += 0.02;
        if (self.zoomY >= 1.5)
        {
            self.flag = YES;
        }
    }
    else
    {
        self.zoomY -= 0.02;
        if (self.zoomY <= 1.0)
        {
            self.flag = NO;
        }
    }
    self.shapeLayer.path = [self waterWavePath];
    
    self.gradientLayer.mask = self.shapeLayer;
}

- (void)addWaveShapeLayer
{
    self.shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    self.shapeLayer.path = [self waterWavePath];
    
    [self.layer addSublayer:self.shapeLayer];
}

- (void)addWaveGradientLayer
{
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = self.bounds;
    [self.layer addSublayer:_gradientLayer];
 
    _gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:116/255.0 green:204/255.0 blue:244/255.0 alpha:1.0].CGColor,
                              (__bridge id)[UIColor colorWithRed:15/255.0 green:94/255.0 blue:156/255.0 alpha:1.0].CGColor];
    _gradientLayer.locations = @[@0.0, @1.0];
 
    CABasicAnimation *gradientAnimation = [CABasicAnimation animationWithKeyPath:@"locations"];
    gradientAnimation.fromValue = @[@0.0, @1.0];
    gradientAnimation.toValue = @[@0.4,@1.0];
    gradientAnimation.duration = 3.0;
    gradientAnimation.repeatCount = HUGE;
    gradientAnimation.autoreverses = YES;
    
    [_gradientLayer addAnimation:gradientAnimation forKey:nil];
    
}


- (CGPathRef)waterWavePath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.waterWaveHeight)];
    CGFloat y = 0.0f;
    for (float x = 0; x <= self.frame.size.width; x++)
    {
        y= - 5 * self.zoomY * sin( x / 150 * M_PI - self.translateX) + self.waterWaveHeight;
        [path addLineToPoint:CGPointMake(x, y)];
    }
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(0, self.waterWaveHeight)];
    [path closePath];
    return [path CGPath];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
