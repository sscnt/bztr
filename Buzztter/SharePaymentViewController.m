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
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    if(userData.premium){
        [self requestPin];
    }else{
        [self layoutSubviews];
        
    }
}

- (void)layoutSubviews
{
    UILabel* label;
    UIFlatBUtton* button;
    UIPremiumSeparator* sep;
    CGFloat viewWidth = [UIScreen screenSize].width - 20.0f;
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    
    //// Scroll
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, [UIScreen screenRect].size.height - 64.0f)];
    [self.view addSubview:_scrollView];
    
    if(userData.premium){
        //// This Device
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, viewWidth, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:14.0f];
        label.text = @"このデバイスで購入し、他のデバイスに課金状態を反映するには、以下の暗証番号を反映したいデバイスに入力してください。";
        label.textColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [label sizeToFit];
        [_scrollView appendView:label margin:10];
        
        //// PIN
        UISharePinLabel* pinLabel = [[UISharePinLabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, viewWidth, 40.0f)];
        pinLabel.text = _pin;
        [_scrollView appendView:pinLabel margin:10];
        
        
        //// Hint
        label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, viewWidth, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:12.0f];
        label.text = @"一度反映すると、次回の購入からはすべてのデバイスに自動的に反映されます。";
        label.textColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        label.textAlignment = NSTextAlignmentLeft;
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 0;
        [label sizeToFit];
        [_scrollView appendView:label margin:10];
        
        
        //// Sep
        sep = [[UIPremiumSeparator alloc] init];
        [_scrollView appendView:sep margin:20];
        
    }
    
    
    //// This Device
    label = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, viewWidth, 0.0f)];
    label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:14.0f];
    label.text = @"他のデバイスで購入し、このデバイスに課金状態を反映するには、購入したデバイスに表示されている暗証番号を入力し確認ボタンを押してください。";
    label.textColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    [label sizeToFit];
    [_scrollView appendView:label margin:10];
    
    _pinTextField = [[UISettingsTextField alloc] initWithFrame:CGRectMake(10.0f, 0.0f, viewWidth, 40.0f)];
    _pinTextField.delegate = self;
    _pinTextField.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:22];
    _pinTextField.textAlignment = NSTextAlignmentCenter;
    [_scrollView appendView:_pinTextField margin:10];
    
    //// Button
    button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(10.0f, 0.0f, viewWidth, 40.0f)];
    [button addTarget:self action:@selector(confirmPin) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"確認" forState:UIControlStateNormal];
    [_scrollView appendView:button margin:10];
    
    //// Padding
    [_scrollView setPadding:400.0f];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    if(userData.premium){
        [_scrollView setContentOffset:CGPointMake(0.0f, 700.0f - [UIScreen screenSize].height)];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)requestPin
{
    
    [SVProgressHUD showWithStatus:@"取得中です" maskType:SVProgressHUDMaskTypeClear];
    _api = [[NSTrendApi alloc] init];
    _api.delegate = self;
    _api.identifier = ApiTypeGetPin;
    NSRequestParams* params = [[NSRequestParams alloc] init];
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    params.user_id_string = [NSString stringWithFormat:@"%d", userData.user_id];
    params.user_token = userData.user_token;
    params.user_token_secret = userData.user_token_secret;
    [_api call:@"enduser/pin" params:params];
}

- (void)confirmPin
{
    if(_pinTextField.text.length == 0){
        [self alert:@"暗証番号を入力してください。"];
        return;
    }
    if(_api == Nil){
        _api = [[NSTrendApi alloc] init];
        _api.delegate = self;
    }
    _api.identifier = ApiTypeConfirmPin;
    NSRequestParams* params = [[NSRequestParams alloc] init];
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    params.user_id_string = [NSString stringWithFormat:@"%d", userData.user_id];
    params.user_token = userData.user_token;
    params.user_token_secret = userData.user_token_secret;
    params.pin = _pinTextField.text;
    [_api call:@"enduser/sync" params:params];
}

- (void)apiDidReturnError:(NSString *)error WithIdentifier:(NSInteger)identifier
{
    [SVProgressHUD dismiss];
    [self alert:error];
}

- (void)apiDidReturnResult:(NSDictionary *)json WithIdentifier:(NSInteger)identifier
{
    [SVProgressHUD dismiss];
    dlog(@"%@", json);
    
    //// Get Pin
    if(identifier == ApiTypeGetPin){
        _pin = [json objectForKey:@"pin"];
        [self layoutSubviews];
        return;
    }
    
    //// Confirm Pin
    if(identifier == ApiTypeConfirmPin){
        if([json objectForKey:@"paied_user_id"] == nil){
            [self alert:@"問題が発生しました。"];
            return;
        }
        NSInteger paied_user_id = [[json objectForKey:@"paied_user_id"] integerValue];
        if(paied_user_id == 0){
            [self alert:@"問題が発生しました。"];
            return;            
        }
        
        NSString* paied_user_token = [json objectForKey:@"paied_user_token"];
        if(paied_user_token.length == 0){
            [self alert:@"問題が発生しました。"];
            return;
        }

        NSString* paied_user_token_secret = [json objectForKey:@"paied_user_token_secret"];
        if(paied_user_token_secret.length == 0){
            [self alert:@"問題が発生しました。"];
            return;
        }
        
        NSEnduserData* userData = [NSEnduserData sharedEnduserData];
        userData.user_id = paied_user_id;
        userData.user_token = paied_user_token;
        userData.user_token_secret = paied_user_token_secret;
        
        
        UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
        alert.delegate = nil;
        alert.message = @"課金状態を反映しました。アプリを再起動してください。";
        alert.title = @"完了";
        int okIndex = [alert addButtonWithTitle:@"OK"];
        [alert setCancelButtonIndex:okIndex];
        [alert show];
        
        return;
    }
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
