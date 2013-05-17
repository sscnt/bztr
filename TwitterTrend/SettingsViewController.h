//
//  SettingsViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+twitter.h"
#import "UIDevice+resolution.h"
#import "UIScreen+twitter.h"
#import "UIView+extend.h"
#import "UIViewController+navi.h"
#import "UIBlackAlertView.h"
#import "NSEnduserData.h"
#import "DCRoundSwitch.h"
#import "UISettingsCellView.h"
#import "UITwitterScrollView.h"

@interface SettingsViewController : UIViewController
{
    DCRoundSwitch* _iCloudSwitch;
    UITwitterScrollView* _scrollView;
}

- (void)didSwitchToggledForICloudEnabled:(id)sender;

@end
