//
//  UITwitterBackgroundView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/02.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "common.h"

@interface UITwitterBackgroundView : UIView

- (id)init;

- (CGRect)contractRect:(CGRect)rect padding:(int)padding;

@end
