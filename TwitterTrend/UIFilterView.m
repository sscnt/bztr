//
//  UIFilterView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterView.h"

@implementation UIFilterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:46.0f/255.0f alpha:1.0f];
        self.clipsToBounds = YES;
        
        UITwitterScrollView* scrollView = [[UITwitterScrollView alloc] initWithFrame:frame];
        [self addSubview:scrollView];
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 15.0f)];
        label.text = @"リツイート数";
        label.backgroundColor = [UIColor clearColor];
        label.shadowColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        label.shadowOffset = CGSizeMake(1.0f, 1.0f);
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:15.0f];
        label.textColor = [UIColor colorWithWhite:225.0f/255.0f alpha:1.0f];
        [scrollView appendView:label margin:215.0f];
        
        UIFilterSliderView* slider = [[UIFilterSliderView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 90.0f)];
        [scrollView appendView:slider margin:10.0f];
        
        UIFilterInnerShadowView* shadow = [[UIFilterInnerShadowView alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 1.0f, frame.size.width, 40.0f)];
        [self addSubview:shadow];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
}

- (void)dealloc
{
    self.delegate = nil;
}

@end
