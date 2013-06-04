//
//  ReportViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
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
#import "UIReportTextView.h"
#import "UIFlatButtonCreator.h"
#import "UIAccessoryView.h"

@interface ReportViewController : UIViewController <UIAlertViewDelegate ,NSTrendApiDelegate>
{
    UIReportTextView* _textView;
    NSTrendApi* _api;
}

- (void)closeKeyboard:(id)sender;
- (void)confirmToSend;

@end
