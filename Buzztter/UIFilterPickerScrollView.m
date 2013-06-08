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
        
        UILabel* label;
        for(int i = 0;i < 10;i++){
            label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, PickerLabelHeight * i, PickerLabelWidth, PickerLabelHeight)];
            label.text = [NSString stringWithFormat:@"%d", i];
            label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0f];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor clearColor];
            [self addSubview:label];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
