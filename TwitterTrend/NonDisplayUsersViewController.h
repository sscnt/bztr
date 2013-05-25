//
//  NonDisplayUsersViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+twitter.h"
#import "UIViewController+navi.h"
#import "UISettingsTableView.h"
#import "UISettingsTableViewCell.h"
#import "UITwitterScrollView.h"
#import "NSFilter.h"
#import "NSFilterUsersFullData.h"

@interface NonDisplayUsersViewController : UIViewController <UISettingsTableViewDelegate>
{
    NSMutableArray* _users;
    UISettingsTableView* _tableView;
    UITwitterScrollView* _scrollView;
}

@end
