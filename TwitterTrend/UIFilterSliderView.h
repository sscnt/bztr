//
//  UIFilterSliderView.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFilterBarBaseView.h"
#import "UIFilterDragView.h"

typedef NS_ENUM(NSInteger, UIFilterDragIdentifier)
{
    UIFilterDragIdentifierMinRT = 0,
    UIFilterDragIdentifierMaxRT,
    UIFilterDragIdentifierMinFav,
    UIFilterDragIdentifierMaxFav
};

@interface UIFilterSliderView : UIView

- (void)setLevels:(NSArray*)levels;
- (void)didDragMinRT:(UIPanGestureRecognizer*)sender;

@end
