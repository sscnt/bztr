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

@interface ImageZoomViewController : UIViewController <UIScrollViewDelegate>
@property (nonatomic, weak) UIImage* image;

- (void)back;

@end
