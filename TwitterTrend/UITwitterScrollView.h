//
//  UITwitterScrollView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIStatusView.h"
#import "UIView+extend.h"
#import "UITwitterScrollHeaderView.h"
#import "UIFilterView.h"

@interface UITwitterScrollView : UIScrollView
{
    CGFloat _margin;
    CGFloat _bottom;
}

- (void)appendView:(UIView*)view;
- (void)appendView:(UIView *)view margin:(NSInteger)margin;
- (void)prependView:(UIView*)view;
- (void)prependView:(UIView*)view margin:(NSInteger)margin;

- (void)removeAllSubviews;

@end
