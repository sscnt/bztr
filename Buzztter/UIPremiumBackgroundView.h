//
//  UIPremiumBackgroundView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/31.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>
#import "UIScreen+twitter.h"
#import "UIPremiumDropShadowView.h"
#import "UIPremiumSeparator.h"
#import "UIView+extend.h"

@interface UIPremiumBackgroundView : UIView
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
