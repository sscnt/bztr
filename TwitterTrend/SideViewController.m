//
//  SIdeMenuViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/05.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "SideViewController.h"

@interface SideViewController ()

@end

@implementation SideViewController

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
    
    [self setMenuButtonItems];
    [self showButtons];
    
}

- (void)setMenuButtonItems
{
    NSMenuItem* item;
    _menuButtons = [NSMutableArray array];
    
    //// General
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"つぶやき（新着順）";
    item.api = @"words/popular";
    item.navigationBarTitle = @"つぶやき";
    item.headerTitle = @"新着順（一般）";
    item.index = 0;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"つぶやき（24時間ランキング）";
    item.api = @"words/top";
    item.navigationBarTitle = @"つぶやき";
    item.headerTitle = @"24時間ランキング（一般）";
    item.index = 1;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"つぶやき（週間ランキング）";
    item.api = @"words/weekly_top";
    item.navigationBarTitle = @"つぶやき";
    item.headerTitle = @"週間ランキング（一般）";
    item.index = 2;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"画像（新着順）";
    item.api = @"images/popular";
    item.navigationBarTitle = @"画像";
    item.headerTitle = @"新着順（一般）";
    item.index = 3;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"画像（24時間ランキング）";
    item.api = @"images/popular";
    item.navigationBarTitle = @"画像";
    item.headerTitle = @"24時間ランキング（一般）";
    item.index = 4;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"画像（週間ランキング）";
    item.api = @"images/popular";
    item.navigationBarTitle = @"画像";
    item.headerTitle = @"週間ランキング（一般）";
    item.index = 5;
    [_menuButtons addObject:item];  

    
    //// Celebrities
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"つぶやき（新着順）";
    item.api = @"words/celebrities";
    item.navigationBarTitle = @"つぶやき";
    item.headerTitle = @"新着順（芸能人・有名人）";
    item.index = 6;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"つぶやき（24時間ランキング）";
    item.api = @"words/top_celebrities";
    item.navigationBarTitle = @"つぶやき";
    item.headerTitle = @"24時間ランキング（芸能人・有名人））";
    item.index = 7;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"つぶやき（週間ランキング）";
    item.api = @"words/weekly_top_celebrities";
    item.navigationBarTitle = @"つぶやき";
    item.headerTitle = @"週間ランキング（芸能人・有名人））";
    item.index = 8;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"画像（新着順）";
    item.api = @"images/celebrities";
    item.navigationBarTitle = @"画像";
    item.headerTitle = @"新着順（芸能人・有名人））";
    item.index = 9;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"画像（24時間ランキング）";
    item.api = @"images/top_celebrities";
    item.navigationBarTitle = @"画像";
    item.headerTitle = @"24時間ランキング（芸能人・有名人））";
    item.index = 10;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"画像（週間ランキング）";
    item.api = @"images/weekly_top_celebrities";
    item.navigationBarTitle = @"画像";
    item.headerTitle = @"週間ランキング（芸能人・有名人））";
    item.index = 11;
    [_menuButtons addObject:item];   
    
    //// About
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"設定";
    item.type = NSMenuItemTypeSettings;
    item.index = 12;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"使い方";
    item.type = NSMenuItemTypeSettings;
    item.index = 13;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"ご意見・不具合の報告など";
    item.type = NSMenuItemTypeSettings;
    item.index = 14;
    [_menuButtons addObject:item];
    
    item = [[NSMenuItem alloc] init];
    item.buttonTitle = @"有料オプションについて";
    item.type = NSMenuItemTypeSettings;
    item.index = 15;
    [_menuButtons addObject:item];
}

- (void)showButtons
{
    //// Separator
    UISideMenuSeparatorView* generalSeparatorView = [[UISideMenuSeparatorView alloc] initWithTitle:@"一般ユーザー"];
    [_scrollView appendView:generalSeparatorView margin:0.0f];
    
    //// Buttons
    NSMutableArray* buttonList = [NSMutableArray array];
    [buttonList addObject:@""];
    [buttonList addObject:@""];
    [buttonList addObject:@""];
    [buttonList addObject:@""];
    [buttonList addObject:@"画像（24時間ランキング）"];
    [buttonList addObject:@"画像（週間ランキング）"];
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
    [buttonList addObject:@"画像（新着順）"];
    [buttonList addObject:@"画像（24時間ランキング）"];
    [buttonList addObject:@"画像（週間ランキング）"];
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
    MainViewController* controller = (MainViewController*)((UITabBarController*)((UINavigationController*)[self sidePanelController].centerPanel).visibleViewController).selectedViewController;
    [controller restart];
    controller.api = @"words/popular";
    controller.headerTitle = @"一般）";
    controller.navigationBarTitle = @"NAVI";
    
    NSInteger selectedIndex = ((UISideMenuButton*)sender).tag;
    for(int index = 0;index < [_menuButtons count];index++){
        UISideMenuButton* button = [_menuButtons objectAtIndex:index];
        button.selected = NO;
        if(button.tag == selectedIndex){
            button.selected = YES;
        }
    }
    _currentButtonIndex = selectedIndex;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
