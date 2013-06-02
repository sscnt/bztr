//
//  UIPremiumDropShadowView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/31.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIPremiumDropShadowView.h"
#import <QuartzCore/CALayer.h>
#import "UIScreen+twitter.h"

@implementation UIPremiumDropShadowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(-6.0, 0.0, [UIScreen screenSize].width + 10.0f, 10.0f)];
        [rectanglePath closePath];
        
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowRadius = 3.0f;
        self.layer.shadowPath = rectanglePath.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.15f;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //// Color Decralations
    UIColor* strokeColor = [UIColor colorWithWhite:255.0f/255.0f alpha:1.0f];
    
    //// Stroke
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0f, 8.0f)];
    [path addLineToPoint:CGPointMake(rect.size.width, 8.0f)];
    [strokeColor setStroke];
    path.lineWidth = 1.0f;
    [path stroke];
}


@end
