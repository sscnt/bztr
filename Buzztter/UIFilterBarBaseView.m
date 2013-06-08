//
//  UIFilterBarBaseView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterBarBaseView.h"

@implementation UIFilterBarBaseView

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
    //// Base
    CGRect baseRect = CGRectMake(rect.origin.x + 1.0f, rect.origin.y + 1.0f, rect.size.width - 2.0f, rect.size.height - 2.0f);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:baseRect cornerRadius:5.0f];
    [[UIColor colorWithWhite:56.0f/255.0f alpha:1.0f] setFill];
    [[UIColor colorWithWhite:0.0f/255.0f alpha:1.0f] setStroke];
    path.lineWidth = 1;
    [path fill];
    [path stroke];
    
    CGRect innerRect = CGRectMake(rect.origin.x + 2.0f, rect.origin.y + 2.0f, rect.size.width - 4.0f, rect.size.height - 4.0f);
    path = [UIBezierPath bezierPathWithRoundedRect:innerRect cornerRadius:5.0f];
    [[UIColor colorWithWhite:255.0f/255.0f alpha:0.10f] setStroke];
    [path stroke];
    
    
    //// Bar Rail
    //////// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat railWidth = self.frame.size.width - 20.0f;

    //////// Color Declarations
    UIColor* railBgColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
    UIColor* railBorderColor = [UIColor colorWithWhite:66.0f/255.0f alpha:1.0f];
    
    //////// Shadow Declarations
    UIColor* shadow = [UIColor colorWithWhite:0.05f alpha:1.0f];
    CGSize shadowOffset = CGSizeMake(1.0f, 2.0f);
    CGFloat shadowBlurRadius = 3.0f;
    
    //////// Rail Drawing
    UIBezierPath* roundedRectanble2Path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10.0f, self.frame.size.height - 40.0f, railWidth, 16.0f) cornerRadius:16.0f];
    [railBgColor setFill];
    [roundedRectanble2Path fill];
    
    //////// Rail Inner Shadow
    CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanble2Path bounds], -shadowBlurRadius, -shadowBlurRadius);
    roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
    roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanble2Path bounds]), -1.0f, -1.0f);
    
    UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect:roundedRectangleBorderRect];
    [roundedRectangleNegativePath appendPath:roundedRectanble2Path];
    roundedRectangleNegativePath.usesEvenOddFillRule = YES;
    
    CGContextSaveGState(context);
    {
        CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
        CGFloat yOffset = shadowOffset.height;
        CGContextSetShadowWithColor(context, CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)), shadowBlurRadius, shadow.CGColor);
        
        [roundedRectanble2Path addClip];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width), 0.0f);
        [roundedRectangleNegativePath applyTransform:transform];
        [[UIColor grayColor] setFill];
        [roundedRectangleNegativePath fill];
    }
    CGContextRestoreGState(context);
    
    [railBorderColor setStroke];
    roundedRectanble2Path.lineWidth = 1.0f;
    [roundedRectanble2Path stroke];   
}

@end
