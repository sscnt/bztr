//
//  UIViewController+navi.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JASidePanelController.h"

@interface UIViewController (navi)

- (void)showMenuBtn;
- (void)showSettingsBtn;

- (void)showMenu:(id)sender;
- (void)showSettings:(id)sender;

- (JASidePanelController *)sidePanelController;

@end
