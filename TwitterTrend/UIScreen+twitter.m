//
//  UIScreen+twitter.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/02.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIScreen+twitter.h"

@implementation UIScreen (twitter)

+ (CGSize)screenSize
{
    return [[self mainScreen] bounds].size;
}
+ (CGRect)screenRect
{
    return CGRectMake([[self mainScreen] bounds].origin.x, [[self mainScreen] bounds].origin.y, [[self mainScreen] bounds].size.width, [[self mainScreen] bounds].size.height);
}
+ (CGFloat)height
{
    return [self screenSize].height;
}
+(CGFloat)width
{
    return [self screenSize].width;
}

@end
