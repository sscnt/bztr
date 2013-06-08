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
    CGRect frame = CGRectMake(0.0f, 0.0f, PickerWidth * 3, PickerHeight);
    return [self initWithFrame:frame];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        _scrollViewHundredPlace = [[UIFilterPickerScrollView alloc] init];
        _scrollViewOnePlace = [[UIFilterPickerScrollView alloc] init];
        _scrollViewTenPlace = [[UIFilterPickerScrollView alloc] init];
        
        _wrapperHundredPlace = [[UIFilterPickerWrapperView alloc] init];
        _wrapperOnePlace = [[UIFilterPickerWrapperView alloc] init];
        _wrapperTenPlace = [[UIFilterPickerWrapperView alloc] init];
        
        [_wrapperHundredPlace setX:0];
        _wrapperHundredPlace.scrollView = _scrollViewHundredPlace;
        [self addSubview:_wrapperHundredPlace];
        [_wrapperTenPlace setX:PickerWidth];
        _wrapperTenPlace.scrollView = _scrollViewTenPlace;
        [self addSubview:_wrapperTenPlace];
        [_wrapperOnePlace setX:PickerWidth * 2];
        _wrapperOnePlace.scrollView = _scrollViewOnePlace;
        [self addSubview:_wrapperOnePlace];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
