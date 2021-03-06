//
//  UITwitterScrollView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UITwitterScrollView.h"

@implementation UITwitterScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _margin = 20.0f;
        _bottom = 0.0f;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//// Adding View
- (void)appendView:(UIView *)view
{
    [self appendView:view margin:_margin];
}

- (void)appendView:(UIView *)view margin:(NSInteger)margin
{
    [view setY:(_bottom + margin)];
    [self addSubview:view];
    CGFloat bottom = view.frame.origin.y + view.frame.size.height;
    if(bottom > _bottom){
        _bottom = bottom;
        [self setContentSize:CGSizeMake(self.frame.size.width, _bottom + _margin)];
    }
}

- (void)prependView:(UIView *)view
{
    [self prependView:view margin:_margin];
}

- (void)prependView:(UIView *)view margin:(NSInteger)margin
{
    
}

- (void)setPadding:(CGFloat)padding
{
    [self setContentSize:CGSizeMake(self.frame.size.width, self.contentSize.height + padding)];
}

- (void)removeBottomPadding
{
    _bottom = 0.0f;
    for(UIView* view in [self subviews]){
        _bottom = MAX(view.bottom, _bottom);
    }
    [self setContentSize:CGSizeMake(self.frame.size.width, _bottom)];
}

- (void)removeAllSubviews
{
    for(UIView* view in [self subviews]){
        if([view isKindOfClass:[UIImageView class]]){

        } else if([view isKindOfClass:[UIFilterView class]]){
        } else {
            [view removeFromSuperview];
        }
    }
    _bottom = 0.0f;
    self.contentSize = CGSizeMake(self.contentSize.width, 0.0f);
}

- (void)sizeToFit
{
    _bottom = 0.0f;
    for(UIView* view in [self subviews]){
        _bottom = MAX(view.bottom, _bottom);
    }
    [self setContentSize:CGSizeMake(self.frame.size.width, _bottom + _margin)];
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    

}


@end
