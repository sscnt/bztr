//
//  UITwitterScrollView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UITwitterScrollView.h"

@implementation UITwitterScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _margin = 20.0f;
        _bottom = 0.0f;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//// Adding View
- (void)appendView:(UIView *)view
{
    
}

- (void)prependView:(UIView *)view
{
    
}


- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    

}


@end
