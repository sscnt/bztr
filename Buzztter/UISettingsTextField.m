//
//  UISettingsTextField.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/26.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UISettingsTextField.h"

@implementation UISettingsTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.borderStyle = UITextBorderStyleNone;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        self.placeholder = @"入力してください";
        self.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16];
        self.returnKeyType = UIReturnKeyDone;
        
        //// Padding
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, frame.size.height)];
        self.leftView = paddingView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        

    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    //// Bar Rail
    //////// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //////// Shadow Declarations
    UIColor* shadow = [UIColor colorWithWhite:0.15f alpha:1.0f];
    CGSize shadowOffset = CGSizeMake(0.0f, 0.0f);
    CGFloat shadowBlurRadius = 2.0f;
    
    //////// Rail Drawing
    UIBezierPath* roundedRectanble2Path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4.0f];
    [[UIColor whiteColor] setFill];
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
    
    [[UIColor colorWithWhite:100.0f/255.0f alpha:1.0f] setStroke];
    roundedRectanble2Path.lineWidth = 1.0f;
    [roundedRectanble2Path stroke];
}

@end
