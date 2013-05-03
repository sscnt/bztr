//
//  UITwitterScrollView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITwitterScrollView : UIScrollView
{
    CGFloat _margin;
    CGFloat _bottom;
}

- (void)appendView:(UIView*)view;
- (void)prependView:(UIView*)view;

@end
