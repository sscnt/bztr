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
#import "IZValueSelectorView.h"
#import "UIFlatBUtton.h"
#import "UIFilterPickerView.h"



@interface FilterViewController : UIViewController <UIFilterViewProtocol, IZValueSelectorViewDataSource, IZValueSelectorViewDelegate>
{
    UITwitterScrollView* _scrollView;
    UIFilterView* _filterView;
}

@property (nonatomic, weak) NSRequestParams* params;

@end
