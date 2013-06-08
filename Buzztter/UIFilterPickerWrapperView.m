//
//  UIFilterPickerWrapperView.m
//  Buzztter
//
//  Created by SSC on 2013/06/09.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterPickerWrapperView.h"

@implementation UIFilterPickerWrapperView

- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, PickerWidth, PickerHeight);
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setScrollView:(UIFilterPickerScrollView *)scrollView
{
    _scrollView = scrollView;
    [self addSubview:scrollView];
}

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self pointInside:point withEvent:event]) {
        return self.scrollView;
    }
    return nil;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
