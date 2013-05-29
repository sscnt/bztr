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
    dlog(@"ViewDidLoad");
    [super viewDidLoad];
    _paymentButtonPressed = NO;
    _paymentStatus = PaymentStatusReady;
    _observerRemmoved = NO;
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    self.tabBarController.navigationItem.title = @"プレミアムサービス";
    
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, [UIScreen screenRect].size.height - 64.0f)];
    
    
    [self.view addSubview:_scrollView];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [self requestProductData];
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)layoutView
{
    SKProduct* product = [_skProductsResponse.products objectAtIndex:0];
    if(product == nil){
        [self error:@"予期せぬエラー。"];
        return;
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setLocale:product.priceLocale];
	NSString *formattedPriceString = [numberFormatter stringFromNumber:product.price];
    
    UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 40.0f)];
    [button setTitle:@"購入する" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickPaymentButton) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView appendView:button margin:20.0f];

}

- (void)requestProductData
{
    [SVProgressHUD showWithStatus:@"お待ちください" maskType:SVProgressHUDMaskTypeClear];
    NSSet *set = [NSSet setWithObjects:@"PremiumService30days", nil];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    productsRequest.delegate = self;
    [productsRequest start];
}

- (void)didRecieveProductData
{
    [self layoutView];
    [SVProgressHUD dismiss];
}

- (void)didFailToRecieveProductData
{
    [SVProgressHUD dismiss];
    [self error:@"予期せぬエラーです。"];
}

- (void)didClickPaymentButton
{
    if(_paymentButtonPressed){
        [self error:@"問題が発生しました。"];
        return;
    }
    if(_paymentStatus != PaymentStatusReady){
        [self error:@"問題が発生しました。"];
        return;
    }
    _paymentButtonPressed = YES;
    if ([SKPaymentQueue canMakePayments]) {
        SKProduct* product = [_skProductsResponse.products objectAtIndex:0];
        if(product == nil){
            [self error:@"予期せぬエラー。"];
            return;
        }
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:product.priceLocale];
        NSString *formattedPriceString = [numberFormatter stringFromNumber:product.price];
        
        UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
        alert.delegate = self;
        alert.message = [NSString stringWithFormat:@"プレミアムサービス（30日間）を%@で購入しますか？", formattedPriceString];
        alert.title = @"確認";
        alert.tag = 1;
        int okIndex = [alert addButtonWithTitle:@"キャンセル"];
        [alert addButtonWithTitle:@"購入"];
        [alert setCancelButtonIndex:okIndex];
        [alert show];
    }else{
        _paymentButtonPressed = NO;
        [self error:@"「App内での購入」がオフになっています。iPhoneの設定を変更してください。"];
    }
}

- (void)paymentExecute
{
    if(_skProductsResponse == nil){
        [self error:@"予期せぬエラーです。"];
        return;
    }
    if(_paymentStatus == PaymentStatusReady){
        if(_observerRemmoved){
            _observerRemmoved = NO;
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        }
        _paymentStatus = PaymentStatusStarted;
        [SVProgressHUD showWithStatus:@"お待ちください" maskType:SVProgressHUDMaskTypeClear];
        BOOL queued = NO;
        for(SKProduct *product in _skProductsResponse.products){
            SKPayment *payment = [SKPayment paymentWithProduct:product];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
            queued = YES;
        }
        if(queued){
            return;
        }
    }
    [self error:@"予期せぬエラーです。"];
}

- (void)error:(NSString *)message
{
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = nil;
    alert.message = message;
    alert.title = @"エラー";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
}

#pragma mark Reciept

- (void)validateReceipt:(NSData *)reciept
{
    dlog(@"Validate receipt");
    [SVProgressHUD dismiss];
    [SVProgressHUD showWithStatus:@"購入を検証中" maskType:SVProgressHUDMaskTypeClear];
    NSRequestParams* params = [[NSRequestParams alloc] init];
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    params.user_id_string = [NSString stringWithFormat:@"%d", userData.user_id];
    params.user_token = userData.user_token;
    params.user_token_secret = userData.user_token_secret;
    params.receipt = [reciept base64EncodedString];
    _api = [[NSTrendApi alloc] init];
    _api.delegate = self;
    [_api call:@"enduser/purchase" params:params];    
}

- (void)didValidateReciept:(NSDictionary *)json
{
    [SVProgressHUD dismiss];
    _paymentStatus = PaymentStatusReady;
    _paymentButtonPressed = NO;
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = nil;
    alert.message = @"購入しました。アプリを再起動してください。";
    alert.title = @"完了";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
}

- (void)apiDidReturnError:(NSString*)error
{
    dlog(@"apiDidReturnError");
    [self error:error];
    [SVProgressHUD dismiss];
    _paymentButtonPressed = NO;
    _paymentStatus = PaymentStatusReady;
}

- (void)apiDidReturnResult:(NSDictionary*)json
{
    dlog(@"%@", json);
    [self didValidateReciept:json];
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
        return;
    }
    
    //// Restore
    if(alertView.tag == 2){
        if(buttonIndex == 1){
            [SVProgressHUD showWithStatus:@"お待ちください" maskType:SVProgressHUDMaskTypeClear];
            [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
        }
    }
}

#pragma mark Purchase

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    if ([response.invalidProductIdentifiers count] > 0) {
        dlog("Invalid Product");
        [self didFailToRecieveProductData];
        return;
    }
    if(response == nil){
        dlog("Response is nil");
        [self didFailToRecieveProductData];
        return;
    }
    if([response.products count] == 0){
        dlog("Products count = 0");
        [self didFailToRecieveProductData];
        return;
    }
    _skProductsResponse = response;
    [self didRecieveProductData];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:// 何らかのOKを押す前の処理
                dlog(@"Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:// success : 決済手続き完了処理
                [queue finishTransaction:transaction];          
                [self validateReceipt:transaction.transactionReceipt];
                return;
                break;
            case SKPaymentTransactionStateFailed://  途中でキャンセルした時
                [queue finishTransaction:transaction];
                dlog(@"Payment canceled.");
                [SVProgressHUD dismiss];
                if(transaction.error.code == SKErrorUnknown){
                    dlog(@"Unknown error.");
                    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
                    alert.delegate = self;
                    alert.message = @"前回の購入処理が中断されています。再開しますか？";
                    alert.title = @"確認";
                    alert.tag = 2;
                    int okIndex = [alert addButtonWithTitle:@"キャンセル"];
                    [alert addButtonWithTitle:@"再開する"];
                    [alert setCancelButtonIndex:okIndex];
                    [alert show];
                    _paymentButtonPressed = YES;
                    _paymentStatus = PaymentStatusStarted;
                    return;
                }
                _paymentButtonPressed = NO;
                _paymentStatus = PaymentStatusReady;
                break;
            case SKPaymentTransactionStateRestored:// 通常はコールされない
                [queue finishTransaction:transaction];
                dlog(@"Payment restored.");
                [SVProgressHUD dismiss];
                _paymentButtonPressed = NO;
                _paymentStatus = PaymentStatusReady;
                break;
            default:
                break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    _observerRemmoved = YES;
}

#pragma mark App State

- (void)applicationDidEnterBackground
{
    dlog(@"applicationDidEnterBackground");
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    _observerRemmoved = YES;
}
- (void)applicationWillEnterForeground
{
    dlog(@"applicationWillEnterForground");
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    _observerRemmoved = YES;
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
