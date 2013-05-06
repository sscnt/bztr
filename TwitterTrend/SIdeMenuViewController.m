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
    _menuButtons = [NSMutableArray array];
    
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
    //// Separator
    UISideMenuSeparatorView* generalSeparatorView = [[UISideMenuSeparatorView alloc] initWithTitle:@"一般ユーザー"];
    [_scrollView appendView:generalSeparatorView margin:0.0f];
    
    //// Buttons
    NSMutableArray* buttonList = [NSMutableArray array];
    [buttonList addObject:@"つぶやき（新着順）"];
    [buttonList addObject:@"つぶやき（24時間ランキング）"];
    [buttonList addObject:@"つぶやき（週間ランキング）"];
    [buttonList addObject:@"写真（新着順）"];
    [buttonList addObject:@"写真（24時間ランキング）"];
    [buttonList addObject:@"写真（週間ランキング）"];
    for(int index = 0;index < [buttonList count];index++){
        UISideMenuButton* button = [[UISideMenuButton alloc] initWithTitle:[buttonList objectAtIndex:index]];
        if(index == _currentButtonIndex){
            button.selected = YES;
        }
        button.tag = index;
        [button addTarget:self action:@selector(didClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [_menuButtons insertObject:button atIndex:index];
        [_scrollView appendView:button margin:0.0f];
    }
    
    //// Separator
    UISideMenuSeparatorView* celebritiesSeparatorView = [[UISideMenuSeparatorView alloc] initWithTitle:@"芸能人・有名人"];
    [_scrollView appendView:celebritiesSeparatorView margin:0.0f];
    
    //// Buttons
    [buttonList addObject:@"つぶやき（新着順）"];
    [buttonList addObject:@"つぶやき（24時間ランキング）"];
    [buttonList addObject:@"つぶやき（週間ランキング）"];
    [buttonList addObject:@"写真（新着順）"];
    [buttonList addObject:@"写真（24時間ランキング）"];
    [buttonList addObject:@"写真（週間ランキング）"];
    for(int index = 6;index < [buttonList count];index++){
        UISideMenuButton* button = [[UISideMenuButton alloc] initWithTitle:[buttonList objectAtIndex:index]];
        if(index == _currentButtonIndex){
            button.selected = YES;
        }
        button.tag = index;
        [button addTarget:self action:@selector(didClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [_menuButtons insertObject:button atIndex:index];
        [_scrollView appendView:button margin:0.0f];
    }
    
    //// Separator
    UISideMenuSeparatorView* aboutSeparatorView = [[UISideMenuSeparatorView alloc] initWithTitle:@"このアプリについて"];
    [_scrollView appendView:aboutSeparatorView margin:0.0f];
    
    
    //// Buttons
    [buttonList addObject:@"設定"];
    [buttonList addObject:@"使い方"];
    [buttonList addObject:@"ご意見・不具合報告など"];
    [buttonList addObject:@"プレミアム会員について"];
    for(int index = 12;index < [buttonList count];index++){
        UISideMenuButton* button = [[UISideMenuButton alloc] initWithTitle:[buttonList objectAtIndex:index]];
        if(index == _currentButtonIndex){
            button.selected = YES;
        }
        button.tag = index;
        [button addTarget:self action:@selector(didClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [_menuButtons insertObject:button atIndex:index];
        [_scrollView appendView:button margin:0.0f];
    }

}

- (void)didClickMenuButton:(id)sender
{
    NSInteger selectedIndex = ((UISideMenuButton*)sender).tag;
    for(int index = 0;index < [_menuButtons count];index++){
        UISideMenuButton* button = [_menuButtons objectAtIndex:index];
        button.selected = NO;
        if(button.tag == selectedIndex){
            button.selected = YES;
        }
        dlog(@"%@", button);

    }
    _currentButtonIndex = selectedIndex;
    dlog(@"%d", selectedIndex);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
