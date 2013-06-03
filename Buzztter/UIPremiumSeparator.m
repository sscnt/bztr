//
//  UIPremiumSeparator.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/31.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIPremiumSeparator.h"

@implementation UIPremiumSeparator

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 1.0f);
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //// Color Decralations
    UIColor* strokeColor = [UIColor colorWithWhite:0.0/255.0f alpha:0.20f];
    
    //// Stroke
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0f, 0.0f)];
    [path addLineToPoint:CGPointMake(rect.size.width, 0.0f)];
    [path closePath];
    [strokeColor setStroke];
    path.lineWidth = 1.0f;
    [path stroke];
    
    //// Color Decralations
    strokeColor = [UIColor colorWithWhite:255.0f/255.0f alpha:0.30f];
    
    //// Stroke
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0f, 1.0f)];
    [path addLineToPoint:CGPointMake(rect.size.width, 1.0f)];
    [path closePath];
    [strokeColor setStroke];
    path.lineWidth = 1.0f;
    [path stroke];
}


@end
