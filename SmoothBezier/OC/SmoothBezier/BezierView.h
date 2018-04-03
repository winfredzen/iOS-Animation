//
//  BezierView.h
//  SmoothBezier
//
//  Created by 王振 on 2018/4/2.
//  Copyright © 2018年 wz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BezierView;

@protocol BezierViewDataSource <NSObject>

- (NSArray *)bezierViewDataPoints:(BezierView *)bezierView;

@end

@interface BezierView : UIView

@property (nonatomic, weak) id<BezierViewDataSource> dataSource;

- (void)drawSmoothLine;

@end
