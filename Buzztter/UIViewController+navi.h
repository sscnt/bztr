//
//  UIViewController+navi.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"
#import "SideViewController.h"
#import "TwitterTimelineViewController.h"

@interface UIViewController (navi)

- (void)showMenuBtn;
- (void)showSettingsBtn;
- (void)hideSettingsBtn;
- (void)showBackButton;

- (void)showMenu:(id)sender;
- (void)showSettings;
- (void)showPremium;
- (void)back;

- (JASidePanelController *)sidePanelController;

@end
