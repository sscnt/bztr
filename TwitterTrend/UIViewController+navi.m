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
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 30)];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"NavigationBarMenuButtonBg"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.tabBarController.navigationItem.leftBarButtonItem = menuBtnItem;
}

- (void)showSettingsBtn
{
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 30)];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"NavigationBarSettingsButtonBg.png"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* menuBtnItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.tabBarController.navigationItem.rightBarButtonItem = menuBtnItem;
}

- (void)showMenu:(id)sender
{
    
}

- (void)showSettings:(id)sender
{
    
}

@end
