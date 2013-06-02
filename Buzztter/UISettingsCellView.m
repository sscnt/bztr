//
//  UISettingsCellView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/14.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UISettingsCellView.h"

@implementation UISettingsCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:4.0f];
        self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        self.layer.shadowRadius = 1.5f;
        self.layer.shadowPath = path.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.2f;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4.0f];
    [[UIColor whiteColor] setFill];
    [path fill];
}

@end
