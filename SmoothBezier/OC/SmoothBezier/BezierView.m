//
//  BezierView.m
//  SmoothBezier
//
//  Created by 王振 on 2018/4/2.
//  Copyright © 2018年 wz. All rights reserved.
//

#import "BezierView.h"
#import "CubicCurveAlgorithm.h"

static NSString *kStrokeAnimationKey = @"StrokeAnimationKey";
static NSString *kFadeAnimationKey = @"FadeAnimationKey";

@interface BezierView()

@property (nonatomic, strong) CubicCurveAlgorithm *cubicCurveAlgorithm;

@property (nonatomic, strong) NSArray* dataPoints;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) BOOL animates;

@property (nonatomic, strong) NSMutableArray* pointLayers;

@property (nonatomic, strong) CAShapeLayer *lineLayer;


@end

@implementation BezierView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initConfig];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initConfig];
    }
    return self;
}

- (void)initConfig
{
    _cubicCurveAlgorithm = [[CubicCurveAlgorithm alloc] init];
    _lineColor = [UIColor colorWithRed:233.0/255.0 green:98.0/255.0 blue:101.0/255.0 alpha:1.0];
    _pointLayers = [NSMutableArray array];
    _animates = YES;
    
}

- (void)drawPoints
{
    if (!self.dataPoints) {
        return;
    }
    
    NSArray *points = self.dataPoints;
    
    for (NSValue *pointValue in points) {
        CGPoint point = [pointValue CGPointValue];
     
        CAShapeLayer *circleLayer = [[CAShapeLayer alloc] init];
        circleLayer.bounds = CGRectMake(0, 0, 12, 12);
        circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:circleLayer.bounds].CGPath;
        circleLayer.fillColor = [UIColor colorWithWhite:248.0/255.0 alpha:0.5].CGColor;
        circleLayer.position = point;
        
        circleLayer.shadowColor = [UIColor blackColor].CGColor;
        circleLayer.shadowOffset = CGSizeMake(0, 2);
        circleLayer.shadowOpacity = 0.7;
        circleLayer.shadowRadius = 3.0;
        
        [self.layer addSublayer:circleLayer];
        
        if (_animates) {
            circleLayer.opacity = 0;
            [_pointLayers addObject:circleLayer];
        }
        
        
    }

}

- (void)drawSmoothLine
{
    NSArray *controlPoints = [_cubicCurveAlgorithm controlPointsFromPoints:self.dataPoints];
    
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    
    for(NSInteger i = 0;i<self.dataPoints.count;i++){
        CGPoint point = [self.dataPoints[i] CGPointValue];
        if(i == 0){
            [linePath moveToPoint:point];
        }else{
            CubicCurveSegment *segment = (CubicCurveSegment *)controlPoints[i-1];
            [linePath addCurveToPoint:point controlPoint1:segment.controlPoint1 controlPoint2:segment.controlPoint2];
        }
    }
    
    _lineLayer = [[CAShapeLayer alloc] init];
    _lineLayer.frame = self.bounds;
    _lineLayer.path = linePath.CGPath;
    _lineLayer.fillColor = [UIColor clearColor].CGColor;
    _lineLayer.strokeColor = [UIColor redColor].CGColor;
    _lineLayer.lineWidth = 4.0;
    
    _lineLayer.shadowColor = [UIColor blackColor].CGColor;
    _lineLayer.shadowOffset = CGSizeMake(0, 8);
    _lineLayer.shadowOpacity = 0.5;
    _lineLayer.shadowRadius = 6.0;
    
    if (_animates) {
        _lineLayer.strokeEnd = 0;
    }
    
    [self.layer addSublayer:_lineLayer];
}

- (void)animateLayers {
    [self animatePoints];
    [self animateLine];
}

- (void)animatePoints{
    
    CGFloat delay = 0.2;
    
    for (CAShapeLayer *point in _pointLayers) {
        CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        fadeAnimation.toValue = @1;
        fadeAnimation.beginTime = CACurrentMediaTime() + delay;
        fadeAnimation.duration = 0.2;
        fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        fadeAnimation.fillMode = kCAFillModeForwards;
        fadeAnimation.removedOnCompletion = NO;
        [point addAnimation:fadeAnimation forKey:kFadeAnimationKey];
        
        delay += 0.15;
    }
}

- (void)animateLine{
    
    CABasicAnimation *growAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    growAnimation.toValue = @1;
    growAnimation.beginTime = CACurrentMediaTime() + 0.5;
    growAnimation.duration = 1.5;
    growAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    growAnimation.fillMode = kCAFillModeForwards;
    growAnimation.removedOnCompletion = NO;
    [_lineLayer addAnimation:growAnimation forKey:kStrokeAnimationKey];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    [self.pointLayers removeAllObjects];
    
    [self drawSmoothLine];
    [self drawPoints];
    
    [self animateLayers];
}

#pragma mark - setter and getter
- (NSArray *)dataPoints
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(bezierViewDataPoints:)]) {
        return [self.dataSource bezierViewDataPoints:self];
    }
    return nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
