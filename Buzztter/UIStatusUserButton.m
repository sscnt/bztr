//
//  UIStatusUserButton.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/11.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIStatusUserButton.h"

@implementation UIStatusUserButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if(self.highlighted){
        UIBezierPath* path = [UIBezierPath bezierPathWithRect:rect];
        [[UIColor colorWithWhite:0.0f alpha:0.1f] setFill];
        [path fill];
    }
}

@end
