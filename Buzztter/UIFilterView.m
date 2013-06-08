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
        scrollView.scrollEnabled = NO;
        [self addSubview:scrollView];
        
        //// Retweet Filter
        _levels = [NSArray arrayWithObjects:@"50",@"100",@"150",@"200",@"250",@"300",@"350",@"400",@"450",@"500",@"600",@"700",@"800",@"900",@"1000",@"1500",@"2000", @"3000", @"4000", @"5000", @"7500",@"10000", @"99999", nil];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 15.0f)];
        label.text = @"リツイート数";
        label.backgroundColor = [UIColor clearColor];
        label.shadowColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        label.shadowOffset = CGSizeMake(1.0f, 1.0f);
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:15.0f];
        label.textColor = [UIColor colorWithWhite:225.0f/255.0f alpha:1.0f];
        [scrollView appendView:label margin:10.0f];
        
        UIFilterSliderView* slider = [[UIFilterSliderView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 90.0f)];
        [slider setLevels:_levels];
        slider.tag = UIFilterSliderIdentifierRetweet;
        slider.delegate = self;
        [scrollView appendView:slider margin:10.0f];
        
        //// Favorite Filter
        label = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 15.0f)];
        label.text = @"お気に入り登録数";
        label.backgroundColor = [UIColor clearColor];
        label.shadowColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        label.shadowOffset = CGSizeMake(1.0f, 1.0f);
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:15.0f];
        label.textColor = [UIColor colorWithWhite:225.0f/255.0f alpha:1.0f];
        [scrollView appendView:label margin:15.0f];
        
        slider = [[UIFilterSliderView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 90.0f)];
        [slider setLevels:_levels];
        slider.tag = UIFilterSliderIdentifierFavorite;
        slider.delegate = self;
        [scrollView appendView:slider margin:10.0f];
                
        //// Apply Button
        UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 40.0f)];
        [button setTitle:@"適用" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(apply) forControlEvents:UIControlEventTouchUpInside];
        [scrollView appendView:button margin:15.0f];
        
        UIFilterInnerShadowView* shadow = [[UIFilterInnerShadowView alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 1.0f, frame.size.width, 40.0f)];
        [self addSubview:shadow];
    }
    return self;
}


#pragma mark UIFilterSliderViewDelegate;

- (void)sliderDidValueChanged:(UIFilterSliderView *)slider
{
    //// Retweet
    if(slider.tag == UIFilterSliderIdentifierRetweet){
        [self.delegate filterDidChangeNumRetweetMax:[[_levels objectAtIndex:slider.currentMaxLevel] integerValue] Min:[[_levels objectAtIndex:slider.currentMinLevel] integerValue]];
        return;
    }
    
    //// Favorite
    if(slider.tag == UIFilterSliderIdentifierFavorite){
        [self.delegate filterDidChangeNumFavoriteMax:[[_levels objectAtIndex:slider.currentMaxLevel] integerValue] Min:[[_levels objectAtIndex:slider.currentMinLevel] integerValue]];
        return;        
    }
}

- (void)apply
{
    [self.delegate filterDidApply];
}

- (void)drawRect:(CGRect)rect
{
    
}

- (void)dealloc
{
    self.delegate = nil;
}

@end
