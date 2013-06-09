//
//  SharePaymentViewController.m
//  Buzztter
//
//  Created by SSC on 2013/06/09.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "SharePaymentViewController.h"

@interface SharePaymentViewController ()

@end

@implementation SharePaymentViewController

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
    self.navigationItem.title = @"購入の共有";
    [self showBackButton];
    [self requestPin];
}

- (void)requestPin
{
    
    [SVProgressHUD showWithStatus:@"取得中です" maskType:SVProgressHUDMaskTypeClear];
    _apiGetPin = [[NSTrendApi alloc] init];
    _apiGetPin.delegate = self;
    NSRequestParams* params = [[NSRequestParams alloc] init];
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    params.user_id_string = [NSString stringWithFormat:@"%d", userData.user_id];
    params.user_token = userData.user_token;
    params.user_token_secret = userData.user_token_secret;
    [_apiGetPin call:@"enduser/pin" params:params];
}

- (void)apiDidReturnError:(NSString *)error
{
    [SVProgressHUD dismiss];
    [self alert:error];
}

- (void)apiDidReturnResult:(NSDictionary *)json
{
    [SVProgressHUD dismiss];
    dlog(@"%@", json);
}

- (void)alert:(NSString *)message
{
    
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = nil;
    alert.message = message;
    alert.title = @"エラー";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
