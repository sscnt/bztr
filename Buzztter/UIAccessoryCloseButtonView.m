//
//  UIAccessoryCloseButtonView.m
//  Minority
//
//  Created by SSC on 2013/03/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIAccessoryCloseButtonView.h"

@implementation UIAccessoryCloseButtonView

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 90.0, 40.0f);
    self = [super initWithFrame:frame];
    if(self){
        UILabel* text = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 90.0f, 36.0f)];
        text.text = @"閉じる";
        text.backgroundColor = [UIColor clearColor];
        text.textAlignment = UITextAlignmentCenter;
        text.font = [UIFont fontWithName:@"07YasashisaGothic" size:13];
        text.font = [UIFont boldSystemFontOfSize:13.0];
        text.shadowOffset = CGSizeMake(0.0f, -1.0f);
        text.shadowColor = [UIColor colorWithRed:48.0f/255.0f green:52.0f/255.0f blue:59.0f/255.0f alpha:1.0f];
        text.textColor = [UIColor whiteColor];
        [self addSubview:text];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    CGFloat width = 89.0;
    CGFloat height = 40.0;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// COlor Declarations
    UIColor* fillCOlor = [UIColor colorWithRed:0.302 green:0.329 blue:0.384 alpha:1];
    UIColor* strokeColor = [UIColor colorWithRed:0.435 green:0.463 blue:0.512 alpha:1];
    UIColor* borderColor = [UIColor colorWithRed:0.208 green:0.227 blue:0.267 alpha:1];
    UIColor* shadowColor2 = [UIColor colorWithRed:0.743 green:0.762 blue:0.788 alpha:1];
    
    //// Gradient Declarations
    NSArray* gradientColors = [NSArray arrayWithObjects:
                               (id)strokeColor.CGColor,
                               (id)fillCOlor.CGColor, nil];
    CGFloat gradientLocations[] = {0,1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    //// Shadow Declarations
    UIColor* shadow = shadowColor2;
    CGSize shadowOffset = CGSizeMake(0.1, 1.1);
    CGFloat shadowBlurRadius = 0;
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.5, 0.5, width - 0.5, height - 1.0) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8.0, 8.0)];
    [roundedRectanglePath closePath];
    CGContextSaveGState(context);
    [roundedRectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(width / 2.0, 0.5), CGPointMake(width / 2.0, height - 0.5), 0);
    CGContextRestoreGState(context);
    
    //// Rounded Rectangle Inner Shadow
CGRect roundedRectangleBorderRect = CGRectInset([roundedRectanglePath bounds], -shadowBlurRadius, -shadowBlurRadius);
roundedRectangleBorderRect = CGRectOffset(roundedRectangleBorderRect, -shadowOffset.width, -shadowOffset.height);
roundedRectangleBorderRect = CGRectInset(CGRectUnion(roundedRectangleBorderRect, [roundedRectanglePath bounds]), -1, -1);

UIBezierPath* roundedRectangleNegativePath = [UIBezierPath bezierPathWithRect:roundedRectangleBorderRect];
[roundedRectangleNegativePath appendPath:roundedRectanglePath];
roundedRectangleNegativePath.usesEvenOddFillRule = YES;

CGContextSaveGState(context);
{
    CGFloat xOffset = shadowOffset.width + round(roundedRectangleBorderRect.size.width);
    CGFloat yOffset = shadowOffset.height;
    CGContextSetShadowWithColor(context,
                                CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                shadowBlurRadius,
                                shadow.CGColor);
    [roundedRectanglePath addClip];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(roundedRectangleBorderRect.size.width),0);
    [roundedRectangleNegativePath applyTransform:transform];
    [[UIColor grayColor] setFill];
    [roundedRectangleNegativePath fill];
}
CGContextRestoreGState(context);

[borderColor setStroke];
roundedRectanglePath.lineWidth = 1.0;
[roundedRectanglePath stroke];

//// Cleanup
CGGradientRelease(gradient);
CGColorSpaceRelease(colorSpace);

}


@end
