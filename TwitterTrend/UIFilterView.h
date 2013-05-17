//
//  UIFilterView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScreen+twitter.h"
#import "UIFilterInnerShadowView.h"
#import "UIFilterSliderView.h"
#import "UITwitterScrollView.h"

@protocol UIFilterViewProtocol <NSObject>

- (void) filterDidChangeNumRetweetMax:(NSInteger)max_rt Min:(NSInteger)min_rt;
- (void) filterDidChangeNumFavoriteMax:(NSInteger)max_fav Min:(NSInteger)min_fav;

@end

@interface UIFilterView : UIView

@property (nonatomic, weak) id<UIFilterViewProtocol> delegate;

@end
