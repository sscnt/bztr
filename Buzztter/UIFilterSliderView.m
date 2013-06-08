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
        _centerMaxX = self.frame.size.width - 20.0f;
        _centerMinX = 20.0f;
        
        //// Label
        _minValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 120.0f, 20.0f, 100.0f, 16.0f)];
        _minValueLabel.text = @"";
        _minValueLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:17.0f];
        _minValueLabel.textAlignment = NSTextAlignmentRight;
        _minValueLabel.backgroundColor = [UIColor clearColor];
        _minValueLabel.textColor = [UIColor colorWithWhite:240.0f/255.0f alpha:1.0f];
        [self addSubview:_minValueLabel];
        _maxVlaueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x, 20.0f, 100.0f, 16.0f)];
        _maxVlaueLabel.text = @"";
        _maxVlaueLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:17.0f];
        _maxVlaueLabel.textAlignment = NSTextAlignmentLeft;
        _maxVlaueLabel.backgroundColor = [UIColor clearColor];
        _maxVlaueLabel.textColor = [UIColor colorWithWhite:240.0f/255.0f alpha:1.0f];
        [self addSubview:_maxVlaueLabel];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 20.0f, 18.0f, 20.0f, 16.0f)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"-";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithWhite:240.0f/255.0f alpha:1.0f];
        [self addSubview:label];
        
        //// Bar
        _bar = [[UIView alloc] initWithFrame:CGRectMake(_centerMinX, 53.0f, (_centerMaxX - _centerMinX), 10.0f)];
        _bar.backgroundColor = [UIColor colorWithRed:174.0f/255.0f green:66.0f/255.0f blue:63.0f/255.0f alpha:1.0f];
        [self addSubview:_bar];
        
        //// Min Knob
        _knobViewMin = [[UIFilterKnobView alloc] initWithFrame:CGRectMake(0.0f, 27.0f, 60.0f, 60.0f)];
        UIPanGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMinKnob:)];
        [_knobViewMin addGestureRecognizer:recognizer];
        [self addSubview:_knobViewMin];
        
        //// Max Knob
        _knobViewMax = [[UIFilterKnobView alloc] initWithFrame:CGRectMake(0.0f, 27.0f, 60.0f, 60.0f)];
        recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMaxKnob:)];
        [_knobViewMax addGestureRecognizer:recognizer];
        [self addSubview:_knobViewMax];
        
    }
    return self;
}

- (void)setLevels:(NSArray *)levels
{
    _levels = levels;
    _maxLevel = [levels count] - 1;
    _currentMinLevel = 0;
    _lastChangedMinLevel = 0;
    [_knobViewMin setCenterX:_centerMinX];
    _currentMaxLevel = _maxLevel;
    _lastChangedMaxLevel = _currentMaxLevel;
    [_knobViewMax setCenterX:_centerMaxX];
    _snapPeriod = (_centerMaxX - _centerMinX) / (_maxLevel + 1);
    _minValueLabel.text = [levels objectAtIndex:0];
    _maxVlaueLabel.text = [levels objectAtIndex:[levels count] - 1];
}

- (void)setBarWidth
{
    CGFloat width = (_centerMaxX - _centerMinX) * (_currentMaxLevel - _currentMinLevel) / _maxLevel;
    CGFloat centerX = _currentMinLevel * _snapPeriod + _centerMinX;
    [_bar setWidth:width];
    [_bar setX:centerX];
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
            [self setMaxKnobPositionWithLevel:tmpLevel];
            [self.delegate sliderDidValueChanged:self];
        }
    }
    return;
}

- (void)setMaxKnobPositionWithLevel:(NSInteger)level
{
    _currentMaxLevel = level;
    CGPoint destinationPoint = CGPointMake((_centerMaxX - _centerMinX) * (_currentMaxLevel + 1) / (_maxLevel + 1) + _centerMinX, _knobViewMax.center.y);
    _knobViewMax.center = destinationPoint;
    _maxVlaueLabel.text = [_levels objectAtIndex:_currentMaxLevel];
    [self setBarWidth];
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
            [self setMinKnobPositionWithLevel:tmpLevel];
            [self.delegate sliderDidValueChanged:self];
        }
    }
    return;
}

- (void)setMinKnobPositionWithLevel:(NSInteger)level
{
    _currentMinLevel = level;
    CGPoint destinationPoint = CGPointMake((_centerMaxX - _centerMinX) * _currentMinLevel / (_maxLevel + 1) + _centerMinX, _knobViewMin.center.y);
    _knobViewMin.center = destinationPoint;
    _minValueLabel.text = [_levels objectAtIndex:_currentMinLevel];
    [self setBarWidth];

}


- (void)dealloc
{
    self.delegate = nil;
}

@end
