//
//  SharePaymentViewController.h
//  Buzztter
//
//  Created by SSC on 2013/06/09.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
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
#import "NSTrendApi.h"
#import "NSRequestParams.h"
#import "UIPremiumSeparator.h"
#import "UISettingsTextField.h"
#import "UISharePinLabel.h"

typedef NS_ENUM(NSInteger, ApiType){
    ApiTypeGetPin = 1,
    ApiTypeConfirmPin
};


@interface SharePaymentViewController : UIViewController <NSTrendApiDelegate, UITextFieldDelegate>
{
    BOOL _shared;
    NSTrendApi* _api;
    NSString* _pin;
    UITwitterScrollView* _scrollView;
    UISettingsTextField* _pinTextField;
}

- (void)layoutSubviews;
- (void)requestPin;
- (void)alert:(NSString*)message;
- (void)confirmPin;

@end
