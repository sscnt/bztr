//
//  UIAnnouncementItemView.h
//  Buzztter
//
//  Created by SSC on 2013/06/16.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>
#import "UIScreen+twitter.h"
#import "NSAnnouncementItem.h"
#import "UILabel+buzztter.h"
#import "UIView+extend.h"

@interface UIAnnouncementItemView : UIView

- (id)initWithItem:(NSAnnouncementItem*)item;

@end
