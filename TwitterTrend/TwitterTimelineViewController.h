//
//  UITimelineViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "commonViews.h"
#import "TwitterTimelineViewModel.h"

@interface TwitterTimelineViewController : UIViewController <TwitterTimelineViewModelDelegate>
{
    UITwitterScrollView* _scrollView;
}

@end
