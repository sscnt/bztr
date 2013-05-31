//
//  UIPremiumBackgroundView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/31.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIPremiumBackgroundView.h"

@implementation UIPremiumBackgroundView

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 500.0f);
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:200.0f/255.0f alpha:1.0f];
        self.layer.masksToBounds = YES;
        
        
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(-6.0, 0.0, [UIScreen screenSize].width + 10.0f, 10.0f)];
        [rectanglePath closePath];
        
        self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
        self.layer.shadowRadius = 0.5f;
        self.layer.shadowPath = rectanglePath.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.3f;
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    //// Color Decralations
    UIColor* strokeColor = [UIColor colorWithWhite:245.0f/255.0f alpha:1.0f];
    
    //// Stroke
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0f, 0.0f)];
    [path addLineToPoint:CGPointMake(rect.size.width, 0.0f)];
    [strokeColor setStroke];
    path.lineWidth = 1.0f;
    [path stroke];
}


@end
