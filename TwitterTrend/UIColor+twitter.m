//
//  UIColor+twitter.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIColor+twitter.h"

@implementation UIColor (twitter)

+(UIColor *)timelineBackgroundColorPrimary
{
    return [self colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f];
}

+(UIColor *)timelineBackgroundColorSecondary
{
    return [self colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
}

+(UIColor *)timelineBackgroundColorStrokeColor
{
    return [self colorWithRed:229.0f/255.0f green:229.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
}

@end
