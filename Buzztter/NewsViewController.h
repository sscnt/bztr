//
//  NewsViewController.h
//  Buzztter
//
//  Created by SSC on 2013/06/16.
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
#import "UIAnnouncementItemView.h"

@interface NewsViewController : UIViewController <NSTrendApiDelegate>
{
    UITwitterScrollView* _scrollView;
    NSTrendApi* _api;
    NSMutableArray* _announcement;
}

- (void)alert:(NSString*)message;
- (void)layoutView;

@end
