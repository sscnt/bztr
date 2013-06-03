//
//  NGWordViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+twitter.h"
#import "UIViewController+navi.h"
#import "UISettingsTableView.h"
#import "UISettingsTableViewCell.h"
#import "UITwitterScrollView.h"
#import "NSFilter.h"
#import "NSFilterWordsFullData.h"
#import "UIBlackAlertView.h"
#import "UISettingsTextField.h"
#import "UIAccessoryView.h"

@interface NGWordViewController : UIViewController <UIActionSheetDelegate, UISettingsTableViewDelegate>
{
    NSMutableArray* _words;
    UISettingsTableView* _tableView;
    UITwitterScrollView* _scrollView;
    UIActionSheet* _actionSheet;
    NSInteger _actionSheetButtonIndexForRemoveNonDisplayUser;
    UISettingsTextField* _textField;
    UILabel* _labelForList;
}

- (void)layout;
- (void)didClickAddButton;
- (void)addNGWord:(NSString*)word;
- (void)closeKeyboard:(id)sender;

@end
