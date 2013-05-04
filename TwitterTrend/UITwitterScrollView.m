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

-(void)prependView:(UIView *)view margin:(NSInteger)margin
{
    
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    

}


@end
