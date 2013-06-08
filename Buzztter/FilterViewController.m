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
        self.navigationItem.title = @"ページ設定";
        self.view.backgroundColor = [UIColor colorWithWhite:46.0f/255.0f alpha:1.0f];
        [self showBackButton];
        
        
        _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, [UIScreen screenSize].height - 64.0f)];
        
        [self.view addSubview:_scrollView];
        _filterView = [[UIFilterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 530.0f)];
        _filterView.delegate = self;
        [_scrollView appendView:_filterView margin:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

- (void)setParams:(NSRequestParams *)params
{
    _params = params;
    [_filterView setMaxRT:_params.max_rt MinRt:_params.min_rt];
    [_filterView setMaxFav:_params.max_fav MinFav:_params.min_fav];
}



#pragma mark UIFilterView


- (void)filterDidApply
{
    UIViewController* prev = [self sidePanelController].timelineViewController;
    [self.navigationController popViewControllerAnimated:YES];
    [prev performSelector:@selector(filterDidApply)];
    dlog(@"%@", [[prev class] description]);
}

- (void)filterDidChangeNumFavoriteMax:(NSInteger)max_fav Min:(NSInteger)min_fav
{
    _params.max_fav = max_fav;
    _params.min_fav = min_fav;
    if(max_fav == 99999){
        _params.max_fav = -1;
    }
}

- (void)filterDidChangeNumRetweetMax:(NSInteger)max_rt Min:(NSInteger)min_rt
{
    _params.max_rt = max_rt;
    _params.min_rt = min_rt;
    if(_params.max_rt == 99999){
        _params.max_rt = -1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
