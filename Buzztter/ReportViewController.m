//
//  ReportViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

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
    
    _textView = [[UIReportTextView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen screenSize].width - 20.0f, 180.0f)];
    
    //// AccessoryView
    UIAccessoryView* accessory = [[UIAccessoryView alloc] initWithStyle:UIAccessoryViewButtonPositionRight];
    [accessory addTarget:self action:@selector(closeKeyboard:)];
    _textView.inputAccessoryView = accessory;
    [self.view addSubview:_textView];
    
    UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(10.0f, _textView.bottom + 10.0f, [UIScreen screenSize].width - 20.0f, 40.0f)];
    [button setTitle:@"送信" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(confirmToSend) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    button = [UIFlatButtonCreator createWhiteButtonWithFrame:CGRectMake(10.0f, button.bottom + 10.0f, [UIScreen screenSize].width - 20.0f, 40.0f)];
    [button setTitle:@"@buzztter_appをフォローする" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(followOnTwitter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)followOnTwitter
{
    
    NSString* urlString = [NSString stringWithFormat:@"twitter://user?id=1388800154"];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        [self alert:@"Twitterアプリがインストールされていません。"];
    }

}

- (void)closeKeyboard:(id)sender
{
    [_textView resignFirstResponder];
}

- (void)confirmToSend
{
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = self;
    alert.message = @"送信しますか？";
    alert.title = @"確認";
    alert.tag = 1;
    int okIndex = [alert addButtonWithTitle:@"キャンセル"];
    [alert setCancelButtonIndex:okIndex];
    [alert addButtonWithTitle:@"送信"];
    [alert show];
    
}

#pragma mark NSTrendAPI


- (void)apiDidReturnError:(NSString*)error
{
    [SVProgressHUD dismiss];
    [self alert:error];
}

- (void)apiDidReturnResult:(NSDictionary*)json
{
    [SVProgressHUD dismiss];
    _textView.text = @"";
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = nil;
    alert.message = @"送信しました";
    alert.title = @"完了";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
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


#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1){
        if(buttonIndex == 1){
            if(_textView.text.length > 1000){
                [self alert:@"文字数が1000文字を超えています。"];
                return;
            }
            if(_textView.text.length < 10){
                [self alert:@"文字数が少なすぎます。"];
                return;
            }
            [SVProgressHUD showWithStatus:@"送信しています" maskType:SVProgressHUDMaskTypeClear];
            _api = [[NSTrendApi alloc] init];
            NSRequestParams* params = [[NSRequestParams alloc] init];
            NSEnduserData* userData = [NSEnduserData sharedEnduserData];
            params.user_token = userData.user_token;
            params.user_id_string = [NSString stringWithFormat:@"%d", userData.user_id];
            params.user_token_secret = userData.user_token_secret;
            params.text = _textView.text;
            params.text = [_textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _api.delegate = self;
            [_api call:@"enduser/report" params:params];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    //// NavigationBar
    self.tabBarController.navigationItem.title = @"ご意見・不具合の報告";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
