//
//  UIFilterPickerView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/27.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFilterPickerWrapperView.h"
#import "UIView+extend.h"


@interface UIFilterPickerView : UIView <UIScrollViewDelegate>
{
    UIFilterPickerScrollView* _scrollViewOnePlace;
    UIFilterPickerScrollView* _scrollViewTenPlace;
    UIFilterPickerScrollView* _scrollViewHundredPlace;
    UIFilterPickerWrapperView* _wrapperOnePlace;
    UIFilterPickerWrapperView* _wrapperTenPlace;
    UIFilterPickerWrapperView* _wrapperHundredPlace;
}

@end
