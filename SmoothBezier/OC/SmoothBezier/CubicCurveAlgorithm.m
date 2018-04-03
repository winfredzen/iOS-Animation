//
//  CubicCurveAlgorithm.m
//  SmoothBezier
//
//  Created by 王振 on 2018/4/2.
//  Copyright © 2018年 wz. All rights reserved.
//

#import "CubicCurveAlgorithm.h"

@implementation CubicCurveSegment

@end

@interface CubicCurveAlgorithm ()

@property (nonatomic, strong) NSMutableArray *firstControlPoints;

@property (nonatomic, strong) NSMutableArray *secondControlPoints;

@end

@implementation CubicCurveAlgorithm

- (instancetype)init
{
    if (self = [super init]) {
        _firstControlPoints = [NSMutableArray array];
        _secondControlPoints = [NSMutableArray array];
    }
    return self;
}


- (NSArray *)controlPointsFromPoints:(NSArray *)dataPoints
{
    //Number of Segments
    NSInteger count = dataPoints.count - 1;
    
    //P0, P1, P2, P3 are the points for each segment, where P0 & P3 are the knots and P1, P2 are the control points.
    if(count == 1){
        CGPoint P0 = [dataPoints[0] CGPointValue];
        CGPoint P3 = [dataPoints[1] CGPointValue];
        
        //Calculate First Control Point
        //3P1 = 2P0 + P3
        
        CGFloat P1x = (2*P0.x + P3.x)/3;
        CGFloat P1y = (2*P0.y + P3.y)/3;
        
        [_firstControlPoints addObject:[NSValue valueWithCGPoint:CGPointMake(P1x, P1y)]];
        
        //Calculate second Control Point
        //P2 = 2P1 - P0
        CGFloat P2x = (2*P1x - P0.x);
        CGFloat P2y = (2*P1y - P0.y);
        
        [_secondControlPoints addObject:[NSValue valueWithCGPoint:CGPointMake(P2x, P2y)]];
    } else {
        
        for (NSUInteger i = 0; i < count; i++) {
            [self.firstControlPoints addObject:[NSNull null]];
        }
        
        NSMutableArray *rhsArray = [NSMutableArray array];
        
        //Array of Coefficients
        NSMutableArray *a = [NSMutableArray array];
        NSMutableArray *b = [NSMutableArray array];
        NSMutableArray *c = [NSMutableArray array];
        
        for(NSInteger i = 0; i < count; i++){
            
            CGFloat rhsValueX = 0;
            CGFloat rhsValueY = 0;
            
            CGPoint P0 = [dataPoints[i] CGPointValue];
            CGPoint P3 = [dataPoints[i+1] CGPointValue];
            
            if(i==0){
                [a addObject:[NSNumber numberWithDouble:0]];
                [b addObject:[NSNumber numberWithDouble:2]];
                [c addObject:[NSNumber numberWithDouble:1]];
                
                //rhs for first segment
                rhsValueX = P0.x + 2*P3.x;
                rhsValueY = P0.y + 2*P3.y;
                
            } else if(i == count-1){
                [a addObject:[NSNumber numberWithDouble:2]];
                [b addObject:[NSNumber numberWithDouble:7]];
                [c addObject:[NSNumber numberWithDouble:0]];
                
                //rhs for last segment
                rhsValueX = 8*P0.x + P3.x;
                rhsValueY = 8*P0.y + P3.y;
            } else {
                [a addObject:[NSNumber numberWithDouble:1]];
                [b addObject:[NSNumber numberWithDouble:4]];
                [c addObject:[NSNumber numberWithDouble:1]];
                
                rhsValueX = 4*P0.x + 2*P3.x;
                rhsValueY = 4*P0.y + 2*P3.y;
            }
            
            [rhsArray addObject:[NSValue valueWithCGPoint:CGPointMake(rhsValueX, rhsValueY)]];
        }
        
        //Solve Ax=B. Use Tridiagonal matrix algorithm a.k.a Thomas Algorithm
        
        for(NSInteger i = 1; i < count; i++) {
            CGFloat rhsValueX = [rhsArray[i] CGPointValue].x;
            CGFloat rhsValueY = [rhsArray[i] CGPointValue].y;
            
            CGFloat prevRhsValueX = [rhsArray[i-1] CGPointValue].x;
            CGFloat prevRhsValueY = [rhsArray[i-1] CGPointValue].y;
            
            double m = [a[i] doubleValue]/[b[i-1] doubleValue];
            
            double b1 = [b[i] doubleValue] - m * [c[i-1] doubleValue];
            b[i] = [NSNumber numberWithDouble:b1];
            
            double r2x = rhsValueX - m * prevRhsValueX;
            double r2y = rhsValueY - m * prevRhsValueY;
            
            rhsArray[i] = [NSValue valueWithCGPoint:CGPointMake(r2x, r2y)];
            
        }
        
        //Get First Control Points
        
        //Last control Point
        double lastControlPointX = [rhsArray[count-1] CGPointValue].x/[b[count-1] doubleValue];
        double lastControlPointY = [rhsArray[count-1] CGPointValue].y/[b[count-1] doubleValue];
        
        _firstControlPoints[count-1] = [NSValue valueWithCGPoint:CGPointMake(lastControlPointX, lastControlPointY)];
        
        for (NSInteger i = count - 2; i >= 0; i--) {
            if (![_firstControlPoints[i+1] isKindOfClass:[NSNull class]]) {
                CGPoint nextControlPoint = [_firstControlPoints[i+1] CGPointValue];
                
                double controlPointX = ([rhsArray[i] CGPointValue].x - [c[i] doubleValue] * nextControlPoint.x)/[b[i] doubleValue];
                double controlPointY = ([rhsArray[i] CGPointValue].y - [c[i] doubleValue] * nextControlPoint.y)/[b[i] doubleValue];
                
                _firstControlPoints[i] = [NSValue valueWithCGPoint:CGPointMake(controlPointX, controlPointY)];
            }
        }
        
        //Compute second Control Points from first
        
        for(NSInteger i=0; i < count; i++) {
            
            if(i == count-1){
                CGPoint P3 = [dataPoints[i+1] CGPointValue];
                
                if ([_firstControlPoints[i] isKindOfClass:[NSNull class]]) {
                    continue;
                }
                
                CGPoint P1 = [_firstControlPoints[i] CGPointValue];
                
                CGFloat controlPointX = (P3.x + P1.x)/2;
                CGFloat controlPointY = (P3.y + P1.y)/2;
                
                [_secondControlPoints addObject:[NSValue valueWithCGPoint:CGPointMake(controlPointX, controlPointY)]];
                
            } else {
                CGPoint P3 = [dataPoints[i+1] CGPointValue];
                
                if ([_firstControlPoints[i+1] isKindOfClass:[NSNull class]]) {
                    continue;
                }
                
                CGPoint nextP1 = [_firstControlPoints[i+1] CGPointValue];
                
                CGFloat controlPointX = 2*P3.x - nextP1.x;
                CGFloat controlPointY = 2*P3.y - nextP1.y;
                
                [_secondControlPoints addObject:[NSValue valueWithCGPoint:CGPointMake(controlPointX, controlPointY)]];
            }
        }
    }
    
    NSMutableArray *controlPoints = [NSMutableArray array];
    
    for (NSInteger i = 0 ; i < count; i++) {
        if (![_firstControlPoints[i] isKindOfClass:[NSNull class]] && ![_secondControlPoints[i] isKindOfClass:[NSNull class]]) {
            CGPoint firstControlPoint = [_firstControlPoints[i] CGPointValue];
            CGPoint secondControlPoint = [_secondControlPoints[i] CGPointValue];
            
            CubicCurveSegment *segment = [[CubicCurveSegment alloc] init];
            segment.controlPoint1 = firstControlPoint;
            segment.controlPoint2 = secondControlPoint;
            
            [controlPoints addObject:segment];
            
        }
    }
    
    
    return controlPoints;
    
}


#pragma mark - 存取器

-(NSMutableArray *)secondControlPoints
{
    if (!_secondControlPoints) {
        _secondControlPoints = [NSMutableArray array];
    }
    return _secondControlPoints;
}

-(NSMutableArray *)firstControlPoints
{
    if (!_firstControlPoints) {
        _firstControlPoints = [NSMutableArray array];
    }
    return _firstControlPoints;
}

@end
