//
//  FilterViewController.m
//  Buzztter
//
//  Created by SSC on 2013/06/08.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (id)init
{
    self = [super init];
    if (self) {
        _didChangeOnlyPage = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"ページ設定";
    self.view.backgroundColor = [UIColor colorWithWhite:46.0f/255.0f alpha:1.0f];
    [self showBackButton];
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, [UIScreen screenSize].height - 64.0f)];
    [self.view addSubview:_scrollView];
    
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    if(userData.premium) {
        _filterView = [[UIFilterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 270.0f)];
        _filterView.delegate = self;
        int maxRT = (_params.max_rt != -1) ? _params.max_rt : 99999;
        int minRT = (_params.min_rt != -1) ? _params.min_rt : 50;
        int maxFav = (_params.max_fav != -1) ? _params.max_fav : 99999;
        int minFav = (_params.min_fav != -1) ? _params.min_fav : 5;
        [_filterView setMaxRT:maxRT MinRt:minRT];
        [_filterView setMaxFav:maxFav MinFav:minFav];
        [_scrollView appendView:_filterView margin:0];
    }
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(14.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 15.0f)];
    label.text = @"ページ番号";
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
    label.shadowOffset = CGSizeMake(1.0f, 1.0f);
    label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:15.0f];
    label.textColor = [UIColor colorWithWhite:225.0f/255.0f alpha:1.0f];
    [_scrollView appendView:label margin:10.0f];
    
    _pickerView = [[UIFilterPickerView alloc] init];
    [_pickerView setCurrentPage:_params.page];
    [_pickerView setX:11];
    [_scrollView appendView:_pickerView margin:10.0f];
    
    UIButton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 40.0f)];
    [button addTarget:self action:@selector(filterDidApply) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"適用" forState:UIControlStateNormal];
    [_scrollView appendView:button margin:15.0f];
}


#pragma mark UIFilterView


- (void)filterDidApply
{
    _params.page = [_pickerView currentPageNumber];
    dlog(@"%d", _params.page);
    UIViewController* prev = [self sidePanelController].timelineViewController;
    [self.navigationController popViewControllerAnimated:YES];
    NSNumber *passedValue = [NSNumber numberWithBool:_didChangeOnlyPage];
    [prev performSelector:@selector(filterDidApply:) withObject:passedValue];
    dlog(@"%@", [[prev class] description]);
}

- (void)filterDidChangeNumFavoriteMax:(NSInteger)max_fav Min:(NSInteger)min_fav
{
    _didChangeOnlyPage = NO;
    _params.max_fav = max_fav;
    _params.min_fav = min_fav;
    if(max_fav == 99999){
        _params.max_fav = -1;
    }
    if(min_fav == 5){
        _params.min_fav = -1;
    }
}

- (void)filterDidChangeNumRetweetMax:(NSInteger)max_rt Min:(NSInteger)min_rt
{
    _didChangeOnlyPage = NO;
    _params.max_rt = max_rt;
    _params.min_rt = min_rt;
    if(_params.max_rt == 99999){
        _params.max_rt = -1;
    }
}

#pragma mark IZValuePicker

- (void)selector:(IZValueSelectorView *)valueSelector didSelectRowAtIndex:(NSInteger)index
{
    
}
- (NSInteger)numberOfRowsInSelector:(IZValueSelectorView *)valueSelector
{
    return 10;
}
- (UIView *)selector:(IZValueSelectorView *)valueSelector viewForRowAtIndex:(NSInteger)index
{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 60.0f, 50.0f, 0.0f)];
    label.text = [NSString stringWithFormat:@"%d", index];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0f];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    return label;
}
- (CGRect)rectForSelectionInSelector:(IZValueSelectorView *)valueSelector
{
    return CGRectMake(0.0f, 0.0f, 80.0f, 60.0f);
}
- (CGFloat)rowHeightInSelector:(IZValueSelectorView *)valueSelector
{
    return 60.0f;
}
- (CGFloat)rowWidthInSelector:(IZValueSelectorView *)valueSelector
{
    return 80.0f;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
