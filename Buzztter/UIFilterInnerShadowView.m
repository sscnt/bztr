//
//  UIFilterInnerShadowView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterInnerShadowView.h"

@implementation UIFilterInnerShadowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(-20.0f, 0.0f, [UIScreen screenSize].width + 40.0f, frame.size.height)];
        [rectanglePath closePath];
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowRadius = 1.0f;
        self.layer.shadowPath = rectanglePath.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.4f;
    }
    return self;
}

@end
