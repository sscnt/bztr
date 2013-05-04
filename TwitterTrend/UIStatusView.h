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
    CGFloat _radius;
}

- (id)initWithStatus:(NSStatus*)status;
- (CGSize)sizeWithStatus:(NSStatus*)status;

//// Layout
- (void)layoutHeader:(NSStatus*)status;
- (void)layoutHeaderProfileImage:(NSStatus*)status;
- (void)layoutHeaderName:(NSStatus*)status;
- (void)layoutContent:(NSStatus*)status;
- (void)layoutFooter:(NSStatus*)status;

@end
