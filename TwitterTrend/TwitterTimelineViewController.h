//
//  UITimelineViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "common.h"
#import "commonViews.h"
#import "TwitterTimelineViewStatusesModel.h"
#import "TwitterTimelineViewDeveloperModel.h"
#import "TwitterTimelineViewEnduserModel.h"
#import "UITwitterScrollHeaderView.h"
#import "ImageZoomViewController.h"
#import "UIFlatButtonCreator.h"
#import "UIFlatBUtton.h"
#import "NSEnduserData.h"

typedef NS_ENUM(int, TimelineViewState){
    TimelineViewStateReady = 0,
    TimelineViewStateLoadingStatuses,
    TimelineViewStateActionSheetShowing
};

typedef NS_ENUM(int, ActionSheetTag){
    ActionSheetTagStatus = 0,
    ActionSheetTagUser
};

typedef NS_ENUM(int, AlertViewIdentifier){
    AlertViewIdentifierDeveloperBlock = 0,
    AlertViewIdentifierRegistration
};

@interface TwitterTimelineViewController : UIViewController <TwitterTimelineViewStatusesModelDelegate, UIGestureRecognizerDelegate, UIStatusViewDelegate, UIActionSheetDelegate, TwitterTimelineViewDeveloperModelDelegate, UIAlertViewDelegate, TwitterTimelineViewEnduserModelDelegate>
{
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
    int _actionSheetUserButtonIndexCancel;
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

- (void)goToNextPageWithProgressHUD;
- (void)goToPrevPageWithProgressHUD;
- (void)goToTopPageWithProgressHUD;

- (void)addSwipeGesture;
- (void)didSwipeRight:(UISwipeGestureRecognizer*)sender;
- (void)didSwipeLeft:(UISwipeGestureRecognizer*)sender;

- (void)didClickImage:(UIImage*)image;
- (void)didClickUserOpenWithButton:(NSStatus*)status;
- (void)didClickStatusOpenWithButton:(NSStatus*)status;

- (void)confirmedAndBlockUser;

@end
