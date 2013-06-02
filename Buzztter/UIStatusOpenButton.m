//
//  UIStatusOpenButton.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/18.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIStatusOpenButton.h"

@implementation UIStatusOpenButton

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 28.0f, 30.0f);
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Open.png"]];
        imageView.frame = CGRectMake(0.0f, 0.0f, 20.0f, 18.0f);
        imageView.center = self.center;
        [self addSubview:imageView];
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
