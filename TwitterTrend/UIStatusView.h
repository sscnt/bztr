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

@interface UIStatusView : UIView

- (id)initWithStatus:(NSStatus*)status;
- (CGSize)sizeWithStatus:(NSStatus*)status;

@end
