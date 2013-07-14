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
    _observerRemmoved = NO;
    pid = @"jp.ssctech.buzz.pro2";
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    self.tabBarController.navigationItem.title = @"プレミアム機能";
    
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
    [super viewWillAppear:animated];
    [self hideSettingsBtn];
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
    
    CGFloat viewWidth = [UIScreen screenSize].width - 40.0f;
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    UILabel* label;
    UIFlatBUtton* button;
    
    //// Premium
    if(userData.premium){
        
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, viewWidth, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:16.0f];
        label.text = @"プレミアム機能を利用できます。";
        [label initOptions];
        [label sizeToFit];
        [_scrollView appendView:label margin:15.0f];
        
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:userData.premium_limit_time];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY年MM月dd日"];
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, viewWidth, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:16.0f];
        label.text = [NSString stringWithFormat:@"%@ まで有効", [formatter stringFromDate:date]];
        [label initOptions];
        label.textColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        [label sizeToFit];
        [_scrollView appendView:label margin:5.0f];

    }else{
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, viewWidth, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:16.0f];
        label.text = @"プレミアム機能でもっと便利に";
        [label initOptions];
        [label sizeToFit];
        [_scrollView appendView:label margin:15.0f];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, viewWidth, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:15.0f];
        label.text = [NSString stringWithFormat:@"%@で30日間プレミアム機能をご利用になれます。", formattedPriceString];
        [label initOptions];
        [label sizeToFit];
        [_scrollView appendView:label margin:5.0f];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, viewWidth, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:12.0f];
        label.text = @"購入日から30日を経過すると利用できなくなりますので再度ご購入ください。また、アプリ削除後再インストールした場合は自動的にリストアされます。";
        [label initOptions];
        label.textColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        [label sizeToFit];
        [_scrollView appendView:label margin:5.0f];
        
        button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(20.0f, 0.0f, viewWidth, 40.0f)];
        [button setTitle:@"購入する" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClickPaymentButton) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView appendView:button margin:20.0f];

    }    
    button = [UIFlatButtonCreator createWhiteButtonWithFrame:CGRectMake(20.0f, 0.0f, viewWidth, 40.0f)];
    [button setTitle:@"リストア" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(willSharePayment) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView appendView:button margin:20.0f];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, viewWidth, 0.0f)];
    label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:12.0f];
    label.text = @"他のデバイスに課金状態を反映する、または他のデバイスの課金状態をこのデバイスに反映するには「リストア」ボタンを押してください。";
    [label initOptions];
    label.textColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
    [label sizeToFit];
    [_scrollView appendView:label margin:5.0f];

    UIPremiumBackgroundView* bgView = [[UIPremiumBackgroundView alloc] init];
    [_scrollView appendView:bgView margin:20.0f];
    [_scrollView removeBottomPadding];

}

- (void)willSharePayment
{
    
    SharePaymentViewController* controller = [[SharePaymentViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)requestProductData
{
    [SVProgressHUD showWithStatus:@"お待ちください" maskType:SVProgressHUDMaskTypeClear];
    NSSet *set = [NSSet setWithObjects:pid, nil];
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
    if(_paymentStatus == PaymentStatusInProgress){
        [self error:@"現在購入処理中です。"];
        return;
    }
    if(_paymentStatus == PaymentStatusFinished){
        [self error:@"購入処理が完了しました。アプリを再起動してください。"];
        return;
    }
    if(_paymentStatus != PaymentStatusReady){
        [self error:@"問題が発生しました。アプリを再起動してください。"];
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
        alert.message = [NSString stringWithFormat:@"%@で購入します。よろしければ「購入」を押してください。", formattedPriceString];
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
    [SVProgressHUD dismiss];
    _paymentStatus = PaymentStatusInProgress;
    dlog(@"Validate receipt");
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
    _paymentStatus = PaymentStatusFinished;
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
            return;
        }
        _paymentStatus = PaymentStatusReady;
        _paymentButtonPressed = NO;
        return;        
    }
}

#pragma mark Purchase

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    if([response.products count] == 0){
        dlog("Products count = 0");
        [self didFailToRecieveProductData];
        return;
    }
    if(response == nil){
        dlog("Response is nil");
        [self didFailToRecieveProductData];
        return;
    }
    dlog(@"%@", response.invalidProductIdentifiers);
    if ([response.invalidProductIdentifiers count] > 0) {
        dlog("Invalid Product");
        [self didFailToRecieveProductData];
        return;
    }
    _skProductsResponse = response;
    [self didRecieveProductData];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    dlog(@"updatedTransactions");
    [SVProgressHUD showWithStatus:@"購入処理中です" maskType:SVProgressHUDMaskTypeClear];
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:// 何らかのOKを押す前の処理
                dlog(@"Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:// success : 決済手続き完了処理
                dlog(@"Purchasing finished.");
                _paymentStatus = PaymentStatusFinished;
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

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    BOOL restore = NO;
    dlog(@"%d", [queue.transactions count]);
    
    for (SKPaymentTransaction *transaction in queue.transactions) {
        // プロダクトIDが一致した場合
        dlog(@"%@", transaction.payment.productIdentifier);
        if ([transaction.payment.productIdentifier isEqualToString:pid]) {
            restore = YES;
            // *** ここに制限解除や広告削除などの課金後の命令を書く ***
            
            break;
        }
    }
    
    // 一致するものがなかった場合
    if (restore == NO) {
        // 通常のアプリ内課金の実行など
        _paymentStatus = PaymentStatusReady;
        [self paymentExecute];
    }
}
- (void) paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    // 失敗した際の処理をここに
    dlog(@"Restore canceled.");
    [SVProgressHUD dismiss];
    _paymentStatus = PaymentStatusReady;
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions
{
    dlog(@"removedTransactions");
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
