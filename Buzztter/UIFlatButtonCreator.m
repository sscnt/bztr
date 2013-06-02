//
//  UIButtonCreator.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/10.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFlatButtonCreator.h"

@implementation UIFlatButtonCreator


+ (UIButton*)createBlackButtonWithFrame:(CGRect)frame
{
    UIFlatBUtton* button = [[UIFlatBUtton alloc] initWithFrame:frame];
    button.bottomColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    button.titleTextColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    button.titleTextShadowColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    button.gradientTopColor = [UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
    button.gradientBottomColor = [UIColor colorWithRed:53.0f/255.0f green:53.0f/255.0f blue:53.0f/255.0f alpha:1.0f];
    button.innerGrowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.15];
    return button;
}
+ (UIButton*)createBlueButtonWithFrame:(CGRect)frame
{
    UIFlatBUtton* button = [[UIFlatBUtton alloc] initWithFrame:frame];
    button.bottomColor = [UIColor colorWithRed:32.0f/255.0f green:85.0f/255.0f blue:154.0f/255.0f alpha:1.0f];
    button.titleTextColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    button.titleTextShadowColor = [UIColor colorWithRed:0.0f/255.0f green:132.0f/255.0f blue:179.0f/255.0f alpha:1.0f];
    button.gradientTopColor = [UIColor colorWithRed:79.0f/255.0f green:195.0f/255.0f blue:234.0f/255.0f alpha:1.0f];
    button.gradientBottomColor = [UIColor colorWithRed:47.0f/255.0f green:153.0f/255.0f blue:188.0f/255.0f alpha:1.0f];
    button.innerGrowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.2];
    return button;
}

+ (UIButton*)createWhiteButtonWithFrame:(CGRect)frame
{
    UIFlatBUtton* button = [[UIFlatBUtton alloc] initWithFrame:frame];
    button.bottomColor = [UIColor colorWithRed:180.0f/255.0f green:180.0f/255.0f blue:180.0f/255.0f alpha:1.0f];
    button.titleTextColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    button.titleTextShadowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    button.gradientTopColor = [UIColor colorWithRed:252.0f/255.0f green:252.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    button.gradientBottomColor = [UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f];
    button.innerGrowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.4];
    return button;
}

+ (UIButton*)createRedButtonWithFrame:(CGRect)frame
{
    UIFlatBUtton* button = [[UIFlatBUtton alloc] initWithFrame:frame];
    button.bottomColor = [UIColor colorWithRed:151.0f/255.0f green:8.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
    button.titleTextColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    button.titleTextShadowColor = [UIColor colorWithRed:151.0f/255.0f green:8.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
    button.gradientTopColor = [UIColor colorWithRed:237.0f/255.0f green:98.0f/255.0f blue:151.0f/255.0f alpha:1.0f];
    button.gradientBottomColor = [UIColor colorWithRed:208.0f/255.0f green:39.0f/255.0f blue:104.0f/255.0f alpha:1.0f];
    button.innerGrowColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.2];
    return button;
}


@end
