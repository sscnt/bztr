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
        _levelsArrayForRT = [NSArray arrayWithObjects:@"50",@"100",@"150",@"200",@"250",@"300",@"350",@"400",@"450",@"500",@"600",@"700",@"800",@"900",@"1000",@"1500",@"2000", @"3000", @"4000", @"5000", @"7500",@"10000", @"99999", nil];
        _levelsArrayForFav = [NSArray arrayWithObjects:@"5",@"50",@"100",@"150",@"200",@"250",@"300",@"350",@"400",@"450",@"500",@"600",@"700",@"800",@"900",@"1000",@"1500",@"2000", @"3000", @"4000", @"5000", @"7500",@"10000", @"99999", nil];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 15.0f)];
        label.text = @"リツイート数";
        label.backgroundColor = [UIColor clearColor];
        label.shadowColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        label.shadowOffset = CGSizeMake(1.0f, 1.0f);
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:15.0f];
        label.textColor = [UIColor colorWithWhite:225.0f/255.0f alpha:1.0f];
        [scrollView appendView:label margin:10.0f];
        
        _rtSlider = [[UIFilterSliderView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 90.0f)];
        [_rtSlider setLevels:_levelsArrayForRT];
        _rtSlider.tag = UIFilterSliderIdentifierRetweet;
        _rtSlider.delegate = self;
        [scrollView appendView:_rtSlider margin:10.0f];
        
        //// Favorite Filter
        label = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 15.0f)];
        label.text = @"お気に入り登録数";
        label.backgroundColor = [UIColor clearColor];
        label.shadowColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        label.shadowOffset = CGSizeMake(1.0f, 1.0f);
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:15.0f];
        label.textColor = [UIColor colorWithWhite:225.0f/255.0f alpha:1.0f];
        [scrollView appendView:label margin:15.0f];
        
        
        _favSlider = [[UIFilterSliderView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 90.0f)];
        [_favSlider setLevels:_levelsArrayForFav];
        _favSlider.tag = UIFilterSliderIdentifierFavorite;
        _favSlider.delegate = self;
        [scrollView appendView:_favSlider margin:10.0f];
                
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



- (NSInteger)value2LevelForFav:(int)value
{
    int level = 0;
    for (NSString* valueString in _levelsArrayForFav) {
        if([valueString isEqualToString:[NSString stringWithFormat:@"%d",value]]){
            return level;
        }
        level++;
    }
    return [_levelsArrayForFav count] - 1;
}

- (NSInteger)value2LevelForRT:(int)value
{
    int level = 0;
    for (NSString* valueString in _levelsArrayForRT) {
        if([valueString isEqualToString:[NSString stringWithFormat:@"%d",value]]){
            return level;
        }
        level++;
    }
    return [_levelsArrayForRT count] - 1;
}
- (void)setMaxFav:(int)max MinFav:(int)min
{
    [_favSlider setMinKnobPositionWithLevel:[self value2LevelForFav:min]];
    [_favSlider setMaxKnobPositionWithLevel:[self value2LevelForFav:max]];
}

- (void)setMaxRT:(int)max MinRt:(int)min
{
    [_rtSlider setMinKnobPositionWithLevel:[self value2LevelForRT:min]];
    [_rtSlider setMaxKnobPositionWithLevel:[self value2LevelForRT:max]];
}

#pragma mark UIFilterSliderViewDelegate;

- (void)sliderDidValueChanged:(UIFilterSliderView *)slider
{
    //// Retweet
    if(slider.tag == UIFilterSliderIdentifierRetweet){
        [self.delegate filterDidChangeNumRetweetMax:[[_levelsArrayForRT objectAtIndex:slider.currentMaxLevel] integerValue] Min:[[_levelsArrayForRT objectAtIndex:slider.currentMinLevel] integerValue]];
        return;
    }
    
    //// Favorite
    if(slider.tag == UIFilterSliderIdentifierFavorite){
        [self.delegate filterDidChangeNumFavoriteMax:[[_levelsArrayForFav objectAtIndex:slider.currentMaxLevel] integerValue] Min:[[_levelsArrayForFav objectAtIndex:slider.currentMinLevel] integerValue]];
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
