//
//  StatusView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSStatus.h"
#import "UIColor+twitter.h"
#import "UIDevice+resolution.h"
#import "UIScreen+twitter.h"
#import "UIView+extend.h"
#import <QuartzCore/CALayer.h>
#import "JMImageCache.h"
#import "UIStatusUserButton.h"

@protocol UIStatusViewDelegate <NSObject>
- (void)didClickImage:(UIImage*)image status:(NSStatus*)status;;
- (void)didClickUserOpenWithButton:(NSStatus*)status;
- (void)didClickStatusOpenWithButton:(NSStatus*)status;
@end

@interface UIStatusView : UIView
{
    NSStatus* _status;
    NSString* _profile_image_url;
    NSString* _media_url;
    UIImageView* _imageView;
    CGFloat _radius;
    UIStatusUserButton* _userOpenWithButton;
    UIButton* _statusOpenWithButton;
    CGFloat _bottomY;
}
@property (nonatomic, weak) id<UIStatusViewDelegate> delegate;

- (id)initWithStatus:(NSStatus*)status;
- (void)setSize;

//// Layout
- (void)layoutHeader;
- (void)layoutHeaderProfileImage;
- (void)layoutHeaderName;
- (void)layoutContent;
- (void)layoutFooter;

//// Button Events
- (void)didClickImage;
- (void)didClickUserOpenWithButton;
- (void)didClickStatusOpenWithButton;

@end
