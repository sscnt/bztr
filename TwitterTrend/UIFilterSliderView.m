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
    UIFilterKnobView* dragView = (UIFilterKnobView*)sender.view;
    CGPoint transitionPoint = [sender translationInView:dragView];
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
        }
        if(_currentMaxLevel != tmpLevel){
            [sender setTranslation:CGPointZero inView:dragView];
            _currentMaxLevel = tmpLevel;
            CGPoint destinationPoint = CGPointMake(_currentMaxLevel * _snapPeriod, dragView.center.y);
            dragView.center = destinationPoint;
            dlog(@"%d", _currentMaxLevel);
        }
    }
    return;
    _currentMaxLevel += deltaLevel;
    if(_currentMaxLevel < 1){
        _currentMaxLevel = 1;
    } else if (_currentMaxLevel > _maxLevel){
        _currentMaxLevel = _maxLevel;
    }
    CGPoint destinationPoint = CGPointMake(_currentMaxLevel * _snapPeriod, dragView.center.y);
    dragView.center = destinationPoint;
    return;
    {
    CGPoint destinationPoint = CGPointMake(dragView.center.x + transitionPoint.x, dragView.center.y);
    CGFloat limitMax = (_currentMinLevel) * _snapPeriod + _centerMinX + _snapPeriod;
    if(destinationPoint.x < limitMax){
        destinationPoint = CGPointMake(limitMax, dragView.center.y);
    }
    if(destinationPoint.x > _centerMaxX){
        destinationPoint = CGPointMake(_centerMaxX, dragView.center.y);
    }
    dragView.center = destinationPoint;
    [sender setTranslation:CGPointZero inView:dragView];
    _currentMaxLevel = floorf((dragView.center.x - _centerMinX) / _snapPeriod);
    }
}

- (void)didDragMinKnob:(UIPanGestureRecognizer *)sender
{
    UIFilterKnobView* dragView = (UIFilterKnobView*)sender.view;
    CGPoint transitionPoint = [sender translationInView:dragView];
    CGPoint destinationPoint = CGPointMake(dragView.center.x + transitionPoint.x, dragView.center.y);
    if(destinationPoint.x < _centerMinX){
        destinationPoint = CGPointMake(_centerMinX, dragView.center.y);
    }
    if(destinationPoint.x > _snapPeriod * _currentMaxLevel){
        destinationPoint = CGPointMake(_snapPeriod * _currentMaxLevel, dragView.center.y);
    }
    dragView.center = destinationPoint;
    [sender setTranslation:CGPointZero inView:dragView];
    
    _currentMinLevel = floorf((dragView.center.x - _centerMinX) / _snapPeriod);
}


- (void)dealloc
{
    self.delegate = nil;
}

@end
