//
//  UIFilterPickerView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/27.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>
#import "UIFilterPickerWrapperView.h"
#import "UIView+extend.h"

typedef NS_ENUM(NSInteger, ScrollViewId){
    ScrollViewIdOnePlace = 0,
    ScrollViewIdTenPlace = 1,
    ScrollViewIdHundredPlace = 2
};

@interface UIFilterPickerView : UIView
{
    UIFilterPickerScrollView* _scrollViewOnePlace;
    UIFilterPickerScrollView* _scrollViewTenPlace;
    UIFilterPickerScrollView* _scrollViewHundredPlace;
    UIFilterPickerWrapperView* _wrapperOnePlace;
    UIFilterPickerWrapperView* _wrapperTenPlace;
    UIFilterPickerWrapperView* _wrapperHundredPlace;
}

- (void)setCurrentPage:(NSInteger)page;
- (NSInteger)currentPageNumber;

@end
