//
//  UIFlatBUtton.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/10.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFlatBUtton.h"

@implementation UIFlatBUtton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.titleLabel setFont:[UIFont fontWithName:@"rounded-mplus-1p-bold" size:14.0f]];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(2.0f, 0.0f, 0.0f, 0.0f)];
    }
    return self;
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
    [self setTitleColor:titleTextColor forState:UIControlStateNormal];
}

- (void)setTitleTextShadowColor:(UIColor *)titleTextShadowColor
{
    [self setTitleShadowColor:titleTextShadowColor forState:UIControlStateNormal];
    [self.titleLabel setShadowOffset:CGSizeMake(1.0f, 1.0f)];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //// General Decralations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Fill Bottom
    UIBezierPath* bottomPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4.0f];
    [self.bottomColor setFill];
    [bottomPath fill];
    
    //// Fill Top
    //////// Gradient Decralations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)self.gradientTopColor.CGColor,
                               (id)self.gradientBottomColor.CGColor,nil];
    if(self.highlighted){
        gradientColors = [NSArray arrayWithObjects:
                                   (id)self.gradientBottomColor.CGColor,
                                   (id)self.gradientBottomColor.CGColor,nil];
    }
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    //////// Drawing
    UIBezierPath* topPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(1.0f, 1.0f, rect.size.width - 2.0f, rect.size.height - 3.0f) cornerRadius:3.0f];
    CGContextSaveGState(context);
    [topPath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(rect.size.width / 2.0f, 0.0f), CGPointMake(rect.size.width / 2.0f, rect.size.height), 0);
    CGContextRestoreGState(context);
    [self.innerGrowColor setStroke];
    topPath.lineWidth = 1;
    [topPath stroke];
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);    
}


@end
