//
//  NewsViewController.m
//  Buzztter
//
//  Created by SSC on 2013/06/16.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

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
    self.tabBarController.navigationItem.title = @"お知らせ";
    
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, [UIScreen screenRect].size.height - 64.0f)];
    
    [self.view addSubview:_scrollView];
    _api = [[NSTrendApi alloc] init];
    
    NSRequestParams* params = [[NSRequestParams alloc] init];
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    params.user_id_string = [NSString stringWithFormat:@"%d", userData.user_id];
    params.user_token = userData.user_token;
    params.user_token_secret = userData.user_token_secret;
    _api.delegate = self;
    [_api call:@"enduser/announcement" params:params];

    [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
}

- (void)layoutView
{
    for (NSAnnouncementItem* item in _announcement) {
        UIAnnouncementItemView* itemView = [[UIAnnouncementItemView alloc] initWithItem:item];
        [_scrollView appendView:itemView margin:10.0f];
    }
}

- (void)alert:(NSString *)message
{
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = self;
    alert.tag = AlertViewIdentifierFetchingAnnouncement;
    alert.message = message;
    alert.title = @"エラー";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
}

#pragma mark API

- (void)apiDidReturnError:(NSString *)error
{
    [SVProgressHUD dismiss];
    [self alert:error];
}

- (void)apiDidReturnResult:(NSDictionary *)json
{
    [SVProgressHUD dismiss];
    if([json objectForKey:@"announcement"] == nil){
        [self alert:@"サーバーで問題が発生しています。"];
        return;
    }
    _announcement = [json objectForKey:@"announcement"];
    [self layoutView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideSettingsBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
