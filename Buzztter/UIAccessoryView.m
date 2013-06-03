//
//  UIAccessoryView.m
//  Minority
//
//  Created by SSC on 2013/03/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIAccessoryView.h"

@implementation UIAccessoryView

- (id)initWithStyle:(UIAccessoryViewButtonPosition)style
{
    CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, 32.0f);
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        button = [[UIAccessoryCloseButtonView alloc] init];
        switch (style) {
            case UIAccessoryViewButtonPositionLeft:
                [button setX:10];
                break;
            case UIAccessoryViewButtonPositionRight:
                [button setX:220];
                break;                
            default:
                break;
        }
        self.clipsToBounds = YES;
        [self addSubview:button];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)selector
{
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)drawRect:(CGRect)rect
{
    
}


@end
