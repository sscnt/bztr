//
//  UIAccessoryView.h
//  Minority
//
//  Created by SSC on 2013/03/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAccessoryCloseButtonView.h"
#import "UIView+extend.h"

typedef NS_ENUM(int, UIAccessoryViewButtonPosition){
    UIAccessoryViewButtonPositionRight = 0,
    UIAccessoryViewButtonPositionLeft
};

@interface UIAccessoryView : UIView
{
    UIAccessoryCloseButtonView* button;
    UILabel* lengthLabel;
}

- (id)initWithStyle:(UIAccessoryViewButtonPosition)style;
- (void)addTarget:(id)target action:(SEL)selector;

@end
