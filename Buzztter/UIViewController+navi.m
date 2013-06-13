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
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"m12.png"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
        self.tabBarController.navigationItem.leftBarButtonItem = menuBtnItem;
    }
}

- (void)showBackButton
{

        UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 30)];
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"m9.png"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
        self.navigationItem.leftBarButtonItem = menuBtnItem;
    
}

- (void)showSettingsBtn
{
    if(self.tabBarController.navigationItem.rightBarButtonItem == nil){
        UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 30)];
        [menuBtn setBackgroundImage:[UIImage imageNamed:@"m13.png"] forState:UIControlStateNormal];
        [menuBtn addTarget:self action:@selector(showSettings) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
        self.tabBarController.navigationItem.rightBarButtonItem = menuBtnItem;
    }
}

- (void)hideSettingsBtn
{
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}


- (void)showMenu:(id)sender
{
    [[self sidePanelController] showLeftPanelAnimated:YES];
}

- (void)showSettings
{
    TwitterTimelineViewController* controller = (TwitterTimelineViewController*)[self sidePanelController].timelineViewController;
    [controller showFilterView];
}

- (void)showPremium
{
    SideViewController* controller = (SideViewController*)[self sidePanelController].leftPanel;
    [controller swithToPremium];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
