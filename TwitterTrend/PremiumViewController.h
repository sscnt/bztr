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

typedef NS_ENUM(NSInteger, PaymentStatus){
    PaymentStatusReady = 0,
    PaymentStatusStarted,
    PaymentStatusFinished
};

@interface PremiumViewController : UIViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver, UIAlertViewDelegate>
{
    BOOL _paymentButtonPressed;
    PaymentStatus _paymentStatus;
    UITwitterScrollView* _scrollView;
    SKProductsRequest* _skProductsRequest;
}

- (void)didClickPaymentButton;
- (void)paymentExecute;

@end
