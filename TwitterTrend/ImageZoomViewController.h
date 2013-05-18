//
//  ImageZoomViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/05.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIScreen+twitter.h"
#import "UIView+extend.h"
#import "NSStatus.h"
#import "UIBlackAlertView.h"

typedef NS_ENUM(int, ImageZoomViewState)
{
    ImageZoomViewStateReady = 0,
    ImageZoomViewStateActionSheetShowing
};

@interface ImageZoomViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate>
{
    UIImageView* _imageView;
    UIActionSheet* _sheet;
    ImageZoomViewState _state;
    int _actionSheetCancelIndex;
    int _actionSheetUrlCopyIndex;
    int _actionSheetOpenWithSafariIndex;
    int _actionSheetOpenwithChromeIndex;
    int _actionSheetOpenwithTwitterIndex;
    int _actionSheetSaveIndex;
    int _actionSheetBackIndex;
}

@property (nonatomic, weak) UIImage* image;
@property (nonatomic, weak) NSStatus* status;

- (void)adjustImageViewOrigin:(UIScrollView*)scrollView;
- (void)back;
- (void)didLongTapped:(id)sender;
- (void)onCompleteCapture:(UIImage *)screenImage didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

@end
