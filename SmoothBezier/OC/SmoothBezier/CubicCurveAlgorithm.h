//
//  CubicCurveAlgorithm.h
//  SmoothBezier
//
//  Created by 王振 on 2018/4/2.
//  Copyright © 2018年 wz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CubicCurveSegment : NSObject

@property (nonatomic, assign) CGPoint controlPoint1;

@property (nonatomic, assign) CGPoint controlPoint2;

@end

@interface CubicCurveAlgorithm : NSObject

- (NSArray *)controlPointsFromPoints:(NSArray *)dataPoints;

@end
