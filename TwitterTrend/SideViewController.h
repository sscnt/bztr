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
#import "UITwitterScrollView.h"
#import "UISideMenuHeaderView.h"
#import "UISideMenuButton.h"
#import "UISideMenuSeparatorView.h"

@interface SideViewController : UIViewController
{
    UITwitterScrollView* _scrollView;
    NSInteger _currentButtonIndex;
    NSMutableArray* _menuButtons;
}

- (void)showButtons;
- (void)didClickMenuButton:(id)sender;

@end
