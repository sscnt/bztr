//
//  UISettingsTableVIewCell.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/25.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+extend.h"

typedef NS_ENUM(NSInteger, CellPosition){
    CellPositionTop = 0,
    CellPositionMiddle,
    CellPositionBottom
};
@class UISettingsTableViewCell;

@protocol UISettingsTableViewCellDelegate <NSObject>

- (void)cell:(UISettingsTableViewCell*)cell highlighted:(BOOL)highlighted;

@end

@interface UISettingsTableViewCell : UIButton
{
    UILabel* _textLabel;
    UILabel* _detailTextLabel;
}

@property (nonatomic, assign) CellPosition position;
@property (nonatomic, assign) BOOL editing;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* detailText;
@property (nonatomic, weak) id<UISettingsTableViewCellDelegate> delegate;

- (void)didClickCell;

@end
