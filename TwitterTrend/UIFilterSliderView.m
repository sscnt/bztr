//
//  UIFilterSliderView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterSliderView.h"

@implementation UIFilterSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIFilterBarBaseView* base = [[UIFilterBarBaseView alloc] initWithFrame:self.bounds];
        [self addSubview:base];
        
        //// Min Knob
        _knobViewMin = [[UIFilterKnobView alloc] initWithFrame:CGRectMake(0.0f, 26.0f, 60.0f, 60.0f)];
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMinKnob:)];
        [_knobViewMin addGestureRecognizer:recognizer];
        [self addSubview:_knobViewMin];
        
        //// Max Knob
        _knobViewMax = [[UIFilterKnobView alloc] initWithFrame:CGRectMake(0.0f, 26.0f, 60.0f, 60.0f)];
        recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMaxKnob:)];
        [_knobViewMax addGestureRecognizer:recognizer];
        [self addSubview:_knobViewMax];
        
        _centerMaxX = self.frame.size.width - 20.0f;
        _centerMinX = 20.0f;
    }
    return self;
}

- (void)setLevels:(NSArray *)levels
{
    _levels = levels;
    _maxLevel = [levels count];
    _currentMinLevel = 0;
    _lastChangedMinLevel = 0;
    [_knobViewMin setCenterX:_centerMinX];
    _currentMaxLevel = _maxLevel;
    _lastChangedMaxLevel = _currentMaxLevel;
    [_knobViewMax setCenterX:_centerMaxX];
    _snapPeriod = (_centerMaxX - _centerMinX) / (_maxLevel + 1);
}

- (void)didDragMaxKnob:(UIPanGestureRecognizer *)sender
{
    UIFilterKnobView* knobView = (UIFilterKnobView*)sender.view;
    [self bringSubviewToFront:knobView];
    CGPoint transitionPoint = [sender translationInView:knobView];
    NSInteger deltaLevel = 0;
    CGFloat deltaLevelFloat = transitionPoint.x / _snapPeriod;
    if(deltaLevelFloat < 0){
        deltaLevel = floorf(deltaLevelFloat) + 1;
    }else{
        deltaLevel = floorf(deltaLevelFloat);
    }
    if(deltaLevel != 0){
        NSInteger tmpLevel = _currentMaxLevel + deltaLevel;
        if(tmpLevel < 1){
            tmpLevel = 1;
        } else if (tmpLevel > _maxLevel){
            tmpLevel = _maxLevel;
        } else if(tmpLevel <= _currentMinLevel){
            tmpLevel = _currentMinLevel + 1;
        }
        if(_currentMaxLevel != tmpLevel){
            [sender setTranslation:CGPointZero inView:knobView];
            _currentMaxLevel = tmpLevel;
            CGPoint destinationPoint = CGPointMake((_centerMaxX - _centerMinX) * (_currentMaxLevel + 1) / (_maxLevel + 1) + _centerMinX, knobView.center.y);
            knobView.center = destinationPoint;
            dlog(@"%d", _currentMaxLevel);
        }
    }
    return;
}

- (void)didDragMinKnob:(UIPanGestureRecognizer *)sender
{
    UIFilterKnobView* knobView = (UIFilterKnobView*)sender.view;
    [self bringSubviewToFront:knobView];
    CGPoint transitionPoint = [sender translationInView:knobView];
    NSInteger deltaLevel = 0;
    CGFloat deltaLevelFloat = transitionPoint.x / _snapPeriod;
    if(deltaLevelFloat < 0){
        deltaLevel = floorf(deltaLevelFloat) + 1;
    }else{
        deltaLevel = floorf(deltaLevelFloat);
    }
    if(deltaLevel != 0){
        NSInteger tmpLevel = _currentMinLevel + deltaLevel;
        if(tmpLevel < 0){
            tmpLevel = 0;
        } else if(tmpLevel >= _currentMaxLevel){
            tmpLevel = _currentMaxLevel - 1;
        }
        if(_currentMinLevel != tmpLevel){
            [sender setTranslation:CGPointZero inView:knobView];
            _currentMinLevel = tmpLevel;
            CGPoint destinationPoint = CGPointMake((_centerMaxX - _centerMinX) * _currentMinLevel / (_maxLevel + 1) + _centerMinX, knobView.center.y);
            knobView.center = destinationPoint;
            dlog(@"%d", _currentMinLevel);
        }
    }
    return;
}


- (void)dealloc
{
    self.delegate = nil;
}

@end
