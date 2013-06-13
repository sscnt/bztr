//
//  SettingsViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, [UIScreen screenRect].size.height - 64.0f)];
    UILabel* label;
    
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    if(userData.premium){
        //// iCloud
        //////// Title
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width, 20.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
        label.text = @"バックアップ";
        [_scrollView appendView:label margin:15.0f];
        
        //////// Switch
        _iCloudSwitch = [[DCRoundSwitch alloc] initWithFrame:CGRectMake([UIScreen screenRect].size.width - 100.0f, 20.0f, 70.0f, 26.0f)];
        [_iCloudSwitch addTarget:self action:@selector(didSwitchToggledForICloudEnabled:) forControlEvents:UIControlEventValueChanged];
        _iCloudSwitch.onText = @"ON";
        _iCloudSwitch.offText = @"OFF";
        _iCloudSwitch.onTintColor = [UIColor colorWithWhite:56.0f/255.0f alpha:1.0f];
        _iCloudSwitch.on = userData.iCloudEnabled;
        
        //////// Text
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen screenRect].size.width - 45.0f - _iCloudSwitch.frame.size.width, 0.0f)];
        label.text = @"ツイート非表示設定をバックアップ可能にする";
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:15.0f];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        
        //////// Cell
        UISettingsCellView* cell = [[UISettingsCellView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen screenRect].size.width - 20.0f, label.frame.size.height + 18.0f)];
        
        //////// Add
        [cell addSubview:label];
        [cell addSubview:_iCloudSwitch];
        [_scrollView appendView:cell margin:5.0f];
    }
    if(userData.premium == NO){
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 20.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:15.0f];
        label.text = @"NGワード設定、指定ユーザー非表示設定、リツイート数・お気に入り登録数の下限・上限指定機能をご利用いただくには、プレミアムサービスの契約（¥350/30日）が必要です。";
        [label sizeToFit];
        [_scrollView appendView:label margin:20.0f];
        
        UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 40.0f)];
        [button setTitle:@"プレミアムサービスについて" forState:UIControlStateNormal];
        [_scrollView appendView:button margin:20.0f];
        
    }else{
        
        //// Filter
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width, 20.0f)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
        label.text = @"ツイート非表示設定";
        [_scrollView appendView:label margin:15.0f];
        
        //// NG Word Button
        UICellButton* button = [[UICellButton alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen screenRect].size.width - 20.0f, label.frame.size.height + 18.0f) byRoundingCouners:UIRectCornerTopLeft | UIRectCornerTopRight];
        [button setTitle:@"NGワードの追加・削除" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClickSettingButtonNGWord) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView appendView:button margin:10.0f];
        
        //// Hide User
        button = [[UICellButton alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen screenRect].size.width - 20.0f, label.frame.size.height + 18.0f) byRoundingCouners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
        [button setTitle:@"非表示ユーザーの管理" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClickSettingButtonManageNonDisplayUsers) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView appendView:button margin:0.0f];
        

    }
    
    [self.view addSubview:_scrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    //// NavigationBar
    self.tabBarController.navigationItem.title = @"設定";
    [self hideSettingsBtn];
}

#pragma mark Hiding Tweets

- (void)didClickSettingButtonNGWord
{
    
    NGWordViewController* controller = [[NGWordViewController alloc] init];
    [self.tabBarController.navigationController pushViewController:controller animated:YES];
    
}

- (void)didClickSettingButtonManageNonDisplayUsers
{
    
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    NonDisplayUsersViewController* controller = [[NonDisplayUsersViewController alloc] init];
    [self.tabBarController.navigationController pushViewController:controller animated:YES];
    
}

#pragma mark Switch for iCloud

- (void)didSwitchToggledForICloudEnabled:(id)sender
{
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    userData.iCloudEnabled = _iCloudSwitch.isOn;
    NSFilter* filter = [NSFilter sharedFilter];
    [filter reopenDatabase];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
