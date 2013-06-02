//
//  UITwitterScrollHeaderView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/05.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+twitter.h"
#import "UIScreen+twitter.h"

@protocol UITwitterScrollHeaderViewDelegate <NSObject>
- (void)didClickOpenFilterPanelButton;
@end

@interface UITwitterScrollHeaderView : UIView
@property (nonatomic, weak) id<UITwitterScrollHeaderViewDelegate> delegate;

- (void)setTitle:(NSString*)title page:(NSInteger)page;

@end
