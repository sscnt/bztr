//
//  UISettingsTableVIewCell.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/25.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CellPosition){
    CellPositionTop = 0,
    CellPositionMiddle,
    CellPositionBottom
};

@interface UISettingsTableViewCell : UIView
{
    UILabel* _textLabel;
    UILabel* _detailTextLabel;
}

@property (nonatomic, assign) CellPosition position;
@property (nonatomic, assign) BOOL editing;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* detailText;

@end
