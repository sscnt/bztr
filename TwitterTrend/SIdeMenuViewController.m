//
//  SIdeMenuViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/05.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentButtonIndex = 0;
    
    //// Background
    self.view.backgroundColor = [UIColor blackColor];
    UIImage* bgImg;
    if([[UIDevice currentDevice] resolution] == UIDeviceResolution_iPhoneRetina5){
        bgImg = [UIImage imageNamed:@"SideMenuBg-568h@2x"];
    }else{
        bgImg = [UIImage imageNamed:@"SideMenuBg"];
    }
    UIImageView* bgImgView = [[UIImageView alloc] initWithImage:bgImg];
    bgImgView.frame = [UIScreen screenRect];
    [self.view addSubview:bgImgView];
    
    //// Scroll
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    //// Header
    UISideMenuHeaderView* headerView = [[UISideMenuHeaderView alloc] initWithTitle:@"メニュー"];
    [_scrollView appendView:headerView margin:0.0f];
    
    [self showButtons];
    
}

- (void)showButtons
{
    UISideMenuSeparatorView* generalSeparatorView = [[UISideMenuSeparatorView alloc] initWithTitle:@"一般ユーザー"];
    [_scrollView appendView:generalSeparatorView margin:0.0f];
    NSArray* generalButtonList = [NSArray arrayWithObjects:@"つぶやき（新着順）", @"つぶやき（24時間ランキング）", @"つぶやき（週間ランキング）", nil];
    for(int index = 0;index < [generalButtonList count];index++){
        UISideMenuButton* button = [[UISideMenuButton alloc] initWithTitle:[generalButtonList objectAtIndex:index]];
        if(index == _currentButtonIndex){
            [button setSelected:YES];
        }
        [_scrollView appendView:button margin:0.0f];
    }
}

- (void)didClickMenuButton:(id)sender
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
