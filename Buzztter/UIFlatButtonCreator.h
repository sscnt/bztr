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

+ (UIFlatBUtton*)createBlackButtonWithFrame:(CGRect)frame;
+ (UIFlatBUtton*)createBlueButtonWithFrame:(CGRect)frame;
+ (UIFlatBUtton*)createWhiteButtonWithFrame:(CGRect)frame;
+ (UIFlatBUtton*)createRedButtonWithFrame:(CGRect)frame;

@end
