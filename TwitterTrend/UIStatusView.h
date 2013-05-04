//
//  StatusView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSStatus.h"
#import "common.h"
#import <QuartzCore/CALayer.h>
#import "JMImageCache.h"

@interface UIStatusView : UIView
{
    __weak NSStatus* _status;
    CGFloat _radius;
    UIButton* _userOpenWithButton;
    UIButton* _statusOpenWithButton;
}

- (id)initWithStatus:(NSStatus*)status;
- (CGSize)sizeWithStatus:(NSStatus*)status;

//// Layout
- (void)layoutHeader;
- (void)layoutHeaderProfileImage;
- (void)layoutHeaderName;
- (void)layoutContent;
- (void)layoutFooter;

//// Button Events
- (void)didClickUserOpenWithButton;
- (void)didClickStatusOpenWithButton;

@end
