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

- (id)init
{
    self = [super init];
    if(self){
        _viewDidUnload = NO;
        _menuButtonItems = [NSMutableArray array];
        _menuButtons = [NSMutableArray array];
        _currentButtonIndex = 0;
        [self initButtonItems];
        [self initButtons];
    }
    return self;
}

- (void)initButtons
{
    if(_menuButtons == nil || [_menuButtons count] == 0){
        _menuButtons = [NSMutableArray array];        
        for(int index = 0;index < [_menuButtonItems count];index++){
            NSMenuItem* item = [self itemAtIndex:index];
            UISideMenuButton* button = [[UISideMenuButton alloc] initWithTitle:item.buttonTitle];
            if(index == _currentButtonIndex){
                button.selected = YES;
            }
            button.tag = item.index;
            [button addTarget:self action:@selector(didClickMenuButton:) forControlEvents:UIControlEventTouchUpInside];
            [_menuButtons insertObject:button atIndex:index];
        }

    }
}

- (void)initButtonItems
{
    NSMenuItem* item;
    if(_menuButtonItems == nil || [_menuButtonItems count] == 0){
        _menuButtonItems = [NSMutableArray array];
        
        //// General
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"つぶやき（新着順）";
        item.api = @"words/popular";
        item.navigationBarTitle = @"つぶやき";
        item.headerTitle = @"新着順（一般）";
        item.index = 0;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"つぶやき（24時間ランキング）";
        item.api = @"words/top";
        item.navigationBarTitle = @"つぶやき";
        item.headerTitle = @"24時間ランキング（一般）";
        item.index = 1;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"つぶやき（週間ランキング）";
        item.api = @"words/weekly_top";
        item.navigationBarTitle = @"つぶやき";
        item.headerTitle = @"週間ランキング（一般）";
        item.index = 2;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"画像（新着順）";
        item.api = @"images/popular";
        item.navigationBarTitle = @"画像";
        item.headerTitle = @"新着順（一般）";
        item.index = 3;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"画像（24時間ランキング）";
        item.api = @"images/top";
        item.navigationBarTitle = @"画像";
        item.headerTitle = @"24時間ランキング（一般）";
        item.index = 4;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"画像（週間ランキング）";
        item.api = @"images/weekly_top";
        item.navigationBarTitle = @"画像";
        item.headerTitle = @"週間ランキング（一般）";
        item.index = 5;
        [_menuButtonItems addObject:item];
        
        
        //// Celebrities
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"つぶやき（新着順）";
        item.api = @"words/celebrities";
        item.navigationBarTitle = @"つぶやき";
        item.headerTitle = @"新着順（芸能人・有名人）";
        item.index = 6;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"つぶやき（24時間ランキング）";
        item.api = @"words/top_celebrities";
        item.navigationBarTitle = @"つぶやき";
        item.headerTitle = @"24時間ランキング（芸能人・有名人）";
        item.index = 7;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"つぶやき（週間ランキング）";
        item.api = @"words/weekly_top_celebrities";
        item.navigationBarTitle = @"つぶやき";
        item.headerTitle = @"週間ランキング（芸能人・有名人）";
        item.index = 8;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"画像（新着順）";
        item.api = @"images/celebrities";
        item.navigationBarTitle = @"画像";
        item.headerTitle = @"新着順（芸能人・有名人）";
        item.index = 9;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"画像（24時間ランキング）";
        item.api = @"images/top_celebrities";
        item.navigationBarTitle = @"画像";
        item.headerTitle = @"24時間ランキング（芸能人・有名人）";
        item.index = 10;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"画像（週間ランキング）";
        item.api = @"images/weekly_top_celebrities";
        item.navigationBarTitle = @"画像";
        item.headerTitle = @"週間ランキング（芸能人・有名人）";
        item.index = 11;
        [_menuButtonItems addObject:item];
        
        //// About
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"設定";
        item.type = NSMenuItemTypeSettings;
        item.index = 12;
        [_menuButtonItems addObject:item];
        

        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"プレミアム会員";
        item.type = NSMenuItemTypePremium;
        item.index = 13;
        [_menuButtonItems addObject:item];
        
        item = [[NSMenuItem alloc] init];
        item.buttonTitle = @"お知らせ";
        item.type = NSMenuItemTypeNews;
        item.index = 14;
        [_menuButtonItems addObject:item];
    }
}

- (void)layout
{    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layout];
}

- (void)viewWillAppear:(BOOL)animated
{
    if(_viewDidUnload){
        _viewDidUnload = NO;
        [self layout];
    }
}


- (NSMenuItem*)itemAtIndex:(NSInteger)index
{
    return (NSMenuItem*)[_menuButtonItems objectAtIndex:index];
}

- (void)showButtons
{
    if(_menuButtonItems == nil){
        [self initButtonItems];
    }
    if(_menuButtons == nil){
        [self initButtons];
    }
    
    //// Separator
    UISideMenuSeparatorView* generalSeparatorView = [[UISideMenuSeparatorView alloc] initWithTitle:@"一般ユーザー"];
    [_scrollView appendView:generalSeparatorView margin:0.0f];
    
    //// Buttons
    for(int index = 0;index < 6;index++){
        UISideMenuButton* button = [_menuButtons objectAtIndex:index];
        if(index == _currentButtonIndex){
            button.selected = YES;
        }
        [_scrollView appendView:button margin:0.0f];
    }
    
    //// Separator
    UISideMenuSeparatorView* celebritiesSeparatorView = [[UISideMenuSeparatorView alloc] initWithTitle:@"芸能人・有名人"];
    [_scrollView appendView:celebritiesSeparatorView margin:0.0f];
    
    //// Buttons
    for(int index = 6;index < 12;index++){
        UISideMenuButton* button = [_menuButtons objectAtIndex:index];
        if(index == _currentButtonIndex){
            button.selected = YES;
        }
        [_scrollView appendView:button margin:0.0f];
    }
    
    //// Separator
    UISideMenuSeparatorView* aboutSeparatorView = [[UISideMenuSeparatorView alloc] initWithTitle:@"このアプリについて"];
    [_scrollView appendView:aboutSeparatorView margin:0.0f];
    
    //// Buttons
    for(int index = 12;index < 15;index++){
        UISideMenuButton* button = [_menuButtons objectAtIndex:index];
        if(index == _currentButtonIndex){
            button.selected = YES;
        }
        if(index == 12){
            NSEnduserData* userData = [NSEnduserData sharedEnduserData];
            if(userData.premium == NO){
                continue;
            }
        }
        [_scrollView appendView:button margin:0.0f];
    }
}

- (void)didClickMenuButton:(id)sender
{
    NSInteger selectedIndex = ((UISideMenuButton*)sender).tag;
    NSMenuItem* item = [self itemAtIndex:selectedIndex];    
        
    for(int index = 0;index < [_menuButtons count];index++){
        UISideMenuButton* button = [_menuButtons objectAtIndex:index];
        button.selected = NO;
        if(button.tag == selectedIndex){
            button.selected = YES;
        }
    }
    _currentButtonIndex = selectedIndex;
    
    UITabBarController* tabbarController = ((UITabBarController*)((UINavigationController*)[self sidePanelController].centerPanel).visibleViewController);

    //// Timeline
    if(item.type == NSMenuItemTypeTimeline){
        tabbarController.selectedIndex = 0;
        TwitterTimelineViewController* controller = [[tabbarController viewControllers] objectAtIndex:0];
        [controller restart];
        controller.api = item.api;
        controller.headerTitle = item.headerTitle;
        controller.navigationBarTitle = item.navigationBarTitle;
        [[self sidePanelController] showCenterPanelAnimated:YES];
        [controller loadStatuses];
        return;
    }
    
    //// Settings
    if(item.type == NSMenuItemTypeSettings){
        tabbarController.selectedIndex = 1;
        [[self sidePanelController] showCenterPanelAnimated:YES];
        return;
    }
    
    //// Help
    if(item.type == NSMenuItemTypeHelp){
        tabbarController.selectedIndex = 2;
        [[self sidePanelController] showCenterPanelAnimated:YES];
        return;
    }
    
    //// Report
    if(item.type == NSMenuItemTypeAsk){
        tabbarController.selectedIndex = 3;
        [[self sidePanelController] showCenterPanelAnimated:YES];
        return;
    }
    
    //// Premium
    if(item.type == NSMenuItemTypePremium){
        tabbarController.selectedIndex = 4;
        [[self sidePanelController] showCenterPanelAnimated:YES];
        return;
    }
    
    //// News
    if(item.type == NSMenuItemTypeNews){
        return;
    }
    
}

- (void)swithToSettings
{
    UISideMenuButton* sender = [_menuButtons objectAtIndex:12];
    _currentButtonIndex = 12;
    [self didClickMenuButton:sender];
}

- (void)swithToPremium
{
    
    UISideMenuButton* sender = [_menuButtons objectAtIndex:13];
    _currentButtonIndex = 13;
    [self didClickMenuButton:sender];
}

- (void)viewDidUnload
{
    dlog(@"viewDidUnload:SideViewController");
    _viewDidUnload = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
