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
#import "UIFlatButtonCreator.h"

typedef NS_ENUM(NSInteger, UIFilterSliderIdentifier)
{
    UIFilterSliderIdentifierRetweet = 0,
    UIFilterSliderIdentifierFavorite
};

@protocol UIFilterViewProtocol <NSObject>

- (void) filterDidChangeNumRetweetMax:(NSInteger)max_rt Min:(NSInteger)min_rt;
- (void) filterDidChangeNumFavoriteMax:(NSInteger)max_fav Min:(NSInteger)min_fav;
- (void) filterDidApply;

@end

@interface UIFilterView : UIView <UIFilterSliderViewDelegate>
{
    NSArray* _levels;
}

@property (nonatomic, weak) id<UIFilterViewProtocol> delegate;

- (void)apply;

@end
