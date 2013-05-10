//
//  UIButtonCreator.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/10.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIFlatBUtton.h"

@interface UIFlatButtonCreator : NSObject

- (UIButton*)createBlackButtonWithFrame:(CGRect)frame;
- (UIButton*)createBlueButtonWithFrame:(CGRect)frame;
- (UIButton*)createWhiteButtonWithFrame:(CGRect)frame;
- (UIButton*)createRedButtonWithFrame:(CGRect)frame;

@end
