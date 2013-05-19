//
//  UIViewController+navi.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIViewController+navi.h"

@implementation UIViewController (navi)

- (void)showMenuBtn
{
    if(self.tabBarController.navigationItem.leftBarButtonItem == nil){
        UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 30)];
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"NavigationBarMenuButtonBg"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
        self.tabBarController.navigationItem.leftBarButtonItem = menuBtnItem;
    }
}

- (void)showSettingsBtn
{
    if(self.tabBarController.navigationItem.rightBarButtonItem == nil){
        UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 30)];
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"NavigationBarSettingsButtonBg.png"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
        self.tabBarController.navigationItem.rightBarButtonItem = menuBtnItem;
    }
}

- (void)showBackButton
{
    
}

- (void)showMenu:(id)sender
{
    [[self sidePanelController] showLeftPanelAnimated:YES];
}

- (void)showSettings:(id)sender
{
    SideViewController* controller = (SideViewController*)[self sidePanelController].leftPanel;
    [controller swithToSettings];
}

- (void)back
{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}

- (JASidePanelController *)sidePanelController {
    UIViewController *iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[JASidePanelController class]]) {
            return (JASidePanelController *)iter;
        } else if (iter.parentViewController && iter.parentViewController != iter) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
