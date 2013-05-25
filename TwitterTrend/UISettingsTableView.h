//
//  UISettingsTableView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/25.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>
#import "UISettingsTableViewCell.h"
#import "UIView+extend.h"

@class UISettingsTableView;

@protocol UISettingsTableViewDelegate <NSObject>

- (NSInteger)numberOfRowsInTableView:(UISettingsTableView *)tableView;
- (UISettingsTableViewCell*)tableView:(UISettingsTableView *)tableView cellForRowAtIndex:(NSInteger)index;

@end

@interface UISettingsTableView : UIView
{
    CGFloat _bottomY;
    
}

@property (nonatomic, weak) id<UISettingsTableViewDelegate> delegate;

- (void)setDropShadow;

@end
