//
//  PremiumViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import "UIColor+twitter.h"
#import "UIDevice+resolution.h"
#import "UIScreen+twitter.h"
#import "UIView+extend.h"
#import "UIViewController+navi.h"
#import "UIBlackAlertView.h"
#import "NSEnduserData.h"
#import "UIFlatButtonCreator.h"
#import "UITwitterScrollView.h"
#import "SVProgressHUD.h"
#import "NSData+Base64.h"
#import "NSTrendApi.h"
#import "NSRequestParams.h"
#import "UIPremiumBackgroundView.h"
#import "SharePaymentViewController.h"
#import "UILabel+buzztter.h"

typedef NS_ENUM(NSInteger, PaymentStatus){
    PaymentStatusReady = 0,
    PaymentStatusStarted,
    PaymentStatusFinished
};

@interface PremiumViewController : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver, UIAlertViewDelegate, NSTrendApiDelegate>
{
    BOOL _paymentButtonPressed;
    BOOL _observerRemmoved;
    PaymentStatus _paymentStatus;
    UITwitterScrollView* _scrollView;
    SKProductsRequest* _skProductsRequest;
    SKProductsResponse* _skProductsResponse;
    NSTrendApi* _api;
}

- (void)layoutView;
- (void)requestProductData;
- (void)didRecieveProductData;
- (void)didFailToRecieveProductData;

- (void)didClickPaymentButton;
- (void)paymentExecute;
- (void)validateReceipt:(NSData*)reciept;
- (void)didValidateReciept:(NSDictionary*)json;

- (void)willSharePayment;

- (void)error:(NSString*)message;

- (void)applicationDidEnterBackground;
- (void)applicationWillEnterForeground;

@end
