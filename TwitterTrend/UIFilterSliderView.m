//
//  UIFilterSliderView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterSliderView.h"

@implementation UIFilterSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIFilterBarBaseView* base = [[UIFilterBarBaseView alloc] initWithFrame:self.bounds];
        [self addSubview:base];
        
        UIFilterDragView* drag = [[UIFilterDragView alloc] initWithFrame:CGRectMake(0.0f, 26.0f, 60.0f, 60.0f)];
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMinRT:)];
        [drag addGestureRecognizer:recognizer];
        drag.tag = UIFilterDragIdentifierMinRT;
        drag.snapPeriod = 50;
        [self addSubview:drag];
    }
    return self;
}

- (void)didDragMinRT:(UIPanGestureRecognizer *)sender
{
    UIView* dragView = sender.view;
    CGPoint p = [sender translationInView:dragView];
    CGPoint to = CGPointMake(dragView.center.x + p.x, dragView.center.y);
    dragView.center = to;
    [sender setTranslation:CGPointZero inView:dragView];
}

@end
