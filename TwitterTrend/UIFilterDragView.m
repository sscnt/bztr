//
//  UIFilterViewDrag.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/17.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterDragView.h"

@implementation UIFilterDragView

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

    //// General Declaration
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat baseWidth = rect.size.width - 30.0f;
    CGFloat shadowWidth = baseWidth - 10.0f;
    CGFloat centerX = rect.size.width / 2.0f;
    
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithWhite:255.0f/255.0f alpha:1.0f];
    UIColor* innerGlow = [UIColor colorWithWhite:255.0f/255.0f alpha:1.0f];
    UIColor* color = [UIColor colorWithWhite:190.0f/255.0f alpha:1.0f];
    
    //// Drop Shadow Drawing
    //////// Color Declarations
    UIColor* shadow = [UIColor blackColor];
    CGSize shadowOffset = CGSizeMake(0.0f, 8.0f);
    CGFloat shadowBlurRadius = 14.0f;
    
    //////// Shadow Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerX - shadowWidth / 2.0f, centerX - shadowWidth / 2.0f, shadowWidth, shadowWidth)];
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
    [[UIColor whiteColor] setFill];
    [ovalPath fill];
    CGContextRestoreGState(context);
    
    //// Base Drawing
    //////// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)fillColor.CGColor,
                               (id)color.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //////// Oval Drawing
    ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(centerX - baseWidth / 2.0f, centerX - baseWidth / 2.0f, baseWidth, baseWidth)];
    [ovalPath addClip];
    CGContextSaveGState(context);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width / 2.0f, centerX - baseWidth / 2.0f), CGPointMake(rect.size.width / 2.0f, centerX + baseWidth / 2.0f), 0);
    [innerGlow setStroke];
    ovalPath.lineWidth = 1.0f;
    [ovalPath stroke];


    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}


@end
