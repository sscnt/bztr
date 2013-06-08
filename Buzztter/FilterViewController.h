//
//  FilterViewController.h
//  Buzztter
//
//  Created by SSC on 2013/06/08.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFilterView.h"
#import "UIColor+twitter.h"
#import "UIDevice+resolution.h"
#import "UIScreen+twitter.h"
#import "UIView+extend.h"
#import "UIViewController+navi.h"
#import "NSRequestParams.h"
#import "UITwitterScrollView.h"


@protocol FilterViewControllerDelegate <NSObject>

- (void) filterDidChangeNumRetweetMax:(NSInteger)max_rt Min:(NSInteger)min_rt;
- (void) filterDidChangeNumFavoriteMax:(NSInteger)max_fav Min:(NSInteger)min_fav;
- (void) filterDidApply;

@end


@interface FilterViewController : UIViewController <UIFilterViewProtocol>
{
    UITwitterScrollView* _scrollView;
    UIFilterView* _filterView;
}

@property (nonatomic, weak) NSRequestParams* params;
@property (nonatomic, weak) id<FilterViewControllerDelegate> delegate;

@end
