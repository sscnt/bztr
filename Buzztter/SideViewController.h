//
//  SIdeMenuViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/05.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+navi.h"
#import "UIScreen+twitter.h"
#import "UIDevice+resolution.h"
#import "UISideMenuHeaderView.h"
#import "UISideMenuButton.h"
#import "UISideMenuSeparatorView.h"
#import "TwitterTimelineViewController.h"
#import "NSMenuItem.h"
#import "UITwitterScrollView.h"
#import "UIBlackAlertView.h"
#import "NSEnduserData.h"

@interface SideViewController : UIViewController
{
    BOOL _viewDidUnload;
    UITwitterScrollView* _scrollView;
    NSMutableArray* _menuButtons;
    NSMutableArray* _menuButtonItems;
}

@property (nonatomic, assign) NSInteger currentButtonIndex;

- (void)initButtons;
- (void)initButtonItems;

- (NSMenuItem*)itemAtIndex:(NSInteger)index;
- (void)showButtons;
- (void)didClickMenuButton:(id)sender;
- (void)layout;
- (void)swithToSettings;
- (void)swithToPremium;

@end
