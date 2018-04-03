//
//  ViewController.m
//  SmoothBezier
//
//  Created by 王振 on 2018/4/2.
//  Copyright © 2018年 wz. All rights reserved.
//

#import "ViewController.h"
#import "BezierView.h"

@interface ViewController ()<BezierViewDataSource>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BezierView *bView = [[BezierView alloc] init];
    bView.frame = self.view.bounds;
    bView.backgroundColor = [UIColor greenColor];
    bView.dataSource = self;
    
    [self.view addSubview:bView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BezierViewDataSource

- (NSArray *)bezierViewDataPoints:(BezierView *)bezierView
{
    return @[[NSValue valueWithCGPoint:CGPointMake(40, 400)],
             [NSValue valueWithCGPoint:CGPointMake(100, 250)],
             [NSValue valueWithCGPoint:CGPointMake(160, 300)],
             [NSValue valueWithCGPoint:CGPointMake(220, 450)],
             [NSValue valueWithCGPoint:CGPointMake(280, 450)],
             [NSValue valueWithCGPoint:CGPointMake(340, 350)]
             ];
}


@end
