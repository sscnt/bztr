//
//  ViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"
#import "commonViews.h"
#import "TwitterTimelineViewController.h"

@interface MainViewController : TwitterTimelineViewController
{
    TwitterTimelineViewModel* _model;
}

@end
