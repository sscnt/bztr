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
#import "TwitterTimelineViewModel.h"
#import "UITwitterScrollHeaderView.h"
#import "ImageZoomViewController.h"

typedef NS_ENUM(int, TimelineViewState){
    TimelineViewStateReady = 0,
    TimelineViewStateLoadingStatuses
};

@interface TwitterTimelineViewController : UIViewController <TwitterTimelineViewModelDelegate, UIGestureRecognizerDelegate, UIStatusViewDelegate>
{
    UITwitterScrollView* _scrollView;
    TwitterTimelineViewModel* _model;
    NSRequestParams* _params;
    NSString* _api;
    NSString* _headerTitle;
    TimelineViewState _state;
}

- (void)loadStatuses;

- (void)goToNextPage;
- (void)goToPrevPage;

- (void)addSwipeGesture;
- (void)didSwipeRight:(UISwipeGestureRecognizer*)sender;
- (void)didSwipeLeft:(UISwipeGestureRecognizer*)sender;

- (void)didClickImage:(UIImage*)image;
- (void)didClickUserOpenWithButton:(NSStatus*)status;
- (void)didClickStatusOpenWithButton:(NSStatus*)status;

@end
