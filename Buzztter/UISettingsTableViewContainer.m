//
//  UISettingsTableViewContainer.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/26.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UISettingsTableViewContainer.h"

@implementation UISettingsTableViewContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0f;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
