//
//  UITwitterBackgroundView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/02.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UITwitterBackgroundView.h"

@implementation UITwitterBackgroundView

- (id)init
{
    CGRect frame = [UIScreen screenRect];
    return [self initWithFrame:frame];
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGFloat padding = 5.0f;
    
    //// Fill Primary
    UIBezierPath* primaryPath = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor timelineBackgroundColorPrimary] setFill];
    [primaryPath fill];
    
    //// Fill Secondary
    CGRect secondaryRect = [self contractRect:rect padding:padding];
    UIBezierPath* secondaryPath = [UIBezierPath bezierPathWithRect:secondaryRect];
    [[UIColor timelineBackgroundColorSecondary] setFill];
    [secondaryPath fill];
    
    //// Fill White
    CGRect whiteRect = [self contractRect:secondaryRect padding:padding];
    UIBezierPath* whiteRectPath = [UIBezierPath bezierPathWithRect:whiteRect];
    [[UIColor whiteColor] setFill];
    [whiteRectPath fill];
    
    //// Stroke
    [[UIColor timelineBackgroundColorStrokeColor] setStroke];
    whiteRectPath.lineWidth = 1;
    [whiteRectPath stroke];
    
}

- (CGRect)contractRect:(CGRect)rect padding:(int)padding
{
    return CGRectMake(rect.origin.x + padding, rect.origin.y, rect.size.width - padding * 2, rect.size.height);
}


@end
