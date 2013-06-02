//
//  UIFilterPickerView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/27.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterPickerView.h"

@implementation UIFilterPickerView


- (id)init
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 166.0f, 50.0f);
    return [super initWithFrame:frame];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _scrollViewHundredPlace = [[UIFilterPickerScrollView alloc] init];
        _scrollViewOnePlace = [[UIFilterPickerScrollView alloc] init];
        _scrollViewTenPlace = [[UIFilterPickerScrollView alloc] init];
        
        [_scrollViewHundredPlace setX:2];
        [self addSubview:_scrollViewHundredPlace];
        [_scrollViewTenPlace setX:56];
        [self addSubview:_scrollViewTenPlace];
        [_scrollViewOnePlace setX:110];
        [self addSubview:_scrollViewOnePlace];        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
