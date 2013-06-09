//
//  UIFilterPickerScrollView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/27.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterPickerScrollView.h"

@implementation UIFilterPickerScrollView

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
        self.pagingEnabled = YES;
        self.contentSize = CGSizeMake(PickerWidth, PickerLabelHeight * 10);
        self.bounds = CGRectMake(0.0f, 0.0f, PickerWidth, PickerLabelHeight);
        self.clipsToBounds = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        UIFilterPickerLabel* label;
        for(int i = 0;i < 10;i++){
            label = [[UIFilterPickerLabel alloc] initWithFrame:CGRectMake(0.0f, PickerLabelHeight * i, PickerLabelWidth, PickerLabelHeight)];
            label.text = [NSString stringWithFormat:@"%d", i];
            [self addSubview:label];
        }
    }
    return self;
}


@end
