//
//  UIFilterSliderView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFilterBarBaseView.h"
#import "UIFilterKnobView.h"
#import "UIView+extend.h"


@class UIFilterSliderView;

@protocol UIFilterSliderViewDelegate <NSObject>

- (void)sliderDidValueChanged:(UIFilterSliderView*)slider;

@end

@interface UIFilterSliderView : UIView
{
    NSArray* _levels;
    CGFloat _snapPeriod;
    NSInteger _maxLevel;
    NSInteger _lastChangedMaxLevel;
    NSInteger _lastChangedMinLevel;
    CGFloat _centerMinX;
    CGFloat _centerMaxX;
    UIFilterKnobView* _knobViewMin;
    UIFilterKnobView* _knobViewMax;
    UILabel* _minValueLabel;
    UILabel* _maxVlaueLabel;
    UIView* _bar;
}

@property (nonatomic, assign) NSInteger currentMaxLevel;
@property (nonatomic, assign) NSInteger currentMinLevel;
@property (nonatomic, weak) id<UIFilterSliderViewDelegate> delegate;

- (void)setLevels:(NSArray*)levels;
- (void)setbarWidth;
- (void)didDragMinKnob:(UIPanGestureRecognizer*)sender;
- (void)didDragMaxKnob:(UIPanGestureRecognizer*)sender;

@end
