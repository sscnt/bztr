//
//  PremiumViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "PremiumViewController.h"

@interface PremiumViewController ()

@end

@implementation PremiumViewController

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
    _paymentButtonPressed = NO;
    _paymentStatus = PaymentStatusReady;
    
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    
    //// NavigationBar
    self.tabBarController.navigationItem.title = @"プレミアムサービス";
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, [UIScreen screenRect].size.height - 64.0f)];
    
    UILabel* label;
    label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 20.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:15.0f];
    label.text = @"";
    [label sizeToFit];
    [_scrollView appendView:label margin:20.0f];
    
    UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 40.0f)];
    [button setTitle:@"¥450/30日" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickPaymentButton) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView appendView:button margin:20.0f];
    
    [self.view addSubview:_scrollView];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)didClickPaymentButton
{
    if(_paymentButtonPressed){
        return;
    }
    if(_paymentStatus != PaymentStatusReady){
        return;
    }
    _paymentButtonPressed = YES;
    if ([SKPaymentQueue canMakePayments]) {
        UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
        alert.delegate = self;
        alert.message = @"プレミアムサービス（30日間）を¥450で購読しますか？なお、自動継続はされません。";
        alert.title = @"確認";
        alert.tag = 1;
        int okIndex = [alert addButtonWithTitle:@"キャンセル"];
        [alert addButtonWithTitle:@"購読"];
        [alert setCancelButtonIndex:okIndex];
        [alert show];
    }else{
        _paymentButtonPressed = NO;
        UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
        alert.delegate = nil;
        alert.message = @"「App内での購入」がオフになっています。iPhoneの設定を変更してください。";
        alert.title = @"エラー";
        int okIndex = [alert addButtonWithTitle:@"OK"];
        [alert setCancelButtonIndex:okIndex];
        [alert show];    
    }
}

- (void)paymentExecute
{
    if(_paymentStatus == PaymentStatusStarted){
        [SVProgressHUD showWithStatus:@"お待ちください" maskType:SVProgressHUDMaskTypeClear];
        _paymentStatus = PaymentStatusStarted;
        NSSet *set = [NSSet setWithObjects:@"PremiumService30days", nil];
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        productsRequest.delegate = self;
        [productsRequest start];
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //// Payment
    if(alertView.tag == 1){
        if(buttonIndex == 1){
            [self paymentExecute];
            return;
        }
        _paymentButtonPressed = NO;
    }
}

#pragma mark Purchase

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    if(response == nil){
        return;
    }
    if(_paymentStatus == PaymentStatusStarted){
        for(SKProduct *product in response.products){
            SKPayment *payment = [SKPayment paymentWithProduct:product];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }
    [SVProgressHUD dismiss];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
