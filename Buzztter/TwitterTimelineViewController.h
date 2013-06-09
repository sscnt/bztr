//
//  UITimelineViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIColor+twitter.h"
#import "UIDevice+resolution.h"
#import "UIScreen+twitter.h"
#import "UIView+extend.h"
#import "UIViewController+navi.h"
#import "NSRequestParams.h"
#import "UIBlackAlertView.h"
#import "UITwitterBackgroundView.h"
#import "UITwitterScrollView.h"
#import "SVProgressHUD.h"
#import "DCRoundSwitch.h"
#import "TwitterTimelineViewStatusesModel.h"
#import "TwitterTimelineViewDeveloperModel.h"
#import "TwitterTimelineViewEnduserModel.h"
#import "UITwitterScrollHeaderView.h"
#import "ImageZoomViewController.h"
#import "UIFlatButtonCreator.h"
#import "UIFlatBUtton.h"
#import "NSEnduserData.h"
#import "FilterViewController.h"

#define StandardPageLimit 3


typedef NS_ENUM(int, TimelineViewState){
    TimelineViewStateReady = 0,
    TimelineViewStateLoadingStatuses,
    TimelineViewStateActionSheetShowing,
    TimelineViewStateSettingMinMax
};

typedef NS_ENUM(int, ActionSheetTag){
    ActionSheetTagStatus = 0,
    ActionSheetTagUser
};

typedef NS_ENUM(int, AlertViewIdentifier){
    AlertViewIdentifierDeveloperBlock = 0,
    AlertViewIdentifierRegistration,
    AlertViewIdentifierFetchingAnnouncement,
    AlertViewIdentifierHideUser
};

typedef NS_ENUM(int, FilterViewState){
    FilterViewStateHidden = 0,
    FilterViewStateDisplay
};

@interface TwitterTimelineViewController : UIViewController <TwitterTimelineViewStatusesModelDelegate, UIGestureRecognizerDelegate,UIStatusViewDelegate, UIActionSheetDelegate, TwitterTimelineViewDeveloperModelDelegate, UIAlertViewDelegate, TwitterTimelineViewEnduserModelDelegate, UIScrollViewDelegate>
{
    BOOL _nextPageExists;
    __weak NSStatus* _currentTargetStatus;
    UITwitterScrollView* _scrollView;
    TwitterTimelineViewStatusesModel* _modelStatuses;
    TwitterTimelineViewDeveloperModel* _modelDeveloper;
    TwitterTimelineViewEnduserModel* _modelEnduser;
    NSRequestParams* _params;
    TimelineViewState _state;
    UIActionSheet* _sheetUser;
    UIActionSheet* _sheetStatus;
    int _actionSheetUserButtonIndexOpenWithTwitterApp;
    int _actionSheetUserButtonIndexDeveloperBlock;
    int _actionSheetUserButtonIndexPremiumHide;
    int _actionSheetUserButtonIndexCancel;
    int _actionSheetStatusButtonIndexOpenWithTwitterApp;
    int _actionSheetStatusButtonIndexCopyUrl;
    int _actionSheetStatusButtonIndexOpenWithSafari;
    int _actionSheetStatusButtonIndexOpenWithChrome;
    int _actionSheetStatusButtonIndexCancel;
    FilterViewState _filterViewState;
}

@property (nonatomic, strong) NSString* api;
@property (nonatomic, strong) NSString* headerTitle;
@property (nonatomic, strong) NSString* navigationBarTitle;

- (void)initializeUser;
- (void)didInitializeUser;
- (void)initializeController;

- (void)restart;
- (void)loadStatuses;

- (void)goToNextPage;
- (void)goToPrevPage;
- (void)goToTopPage;

- (void)showFilterView;

- (void)goToNextPageWithProgressHUD;
- (void)goToPrevPageWithProgressHUD;
- (void)goToTopPageWithProgressHUD;

- (void)filterDidApply:(BOOL)didChangeOnlyPage;

- (void)addSwipeGesture;
- (void)didSwipeRight:(UISwipeGestureRecognizer*)sender;
- (void)didSwipeLeft:(UISwipeGestureRecognizer*)sender;

- (void)didClickUserOpenWithButton:(NSStatus*)status;
- (void)didClickStatusOpenWithButton:(NSStatus*)status;

- (void)presentToPremium;

@end
