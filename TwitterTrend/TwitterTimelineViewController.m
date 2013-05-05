//
//  UITimelineViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterTimelineViewController.h"

@interface TwitterTimelineViewController ()

@end

@implementation TwitterTimelineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    UITwitterBackgroundView* bg = [[UITwitterBackgroundView alloc] init];
    [self.view addSubview:bg];
    [self showMenuBtn];
    [self showSettingsBtn];
    
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, self.view.frame.size.height - 44.0f)];
    [self.view addSubview:_scrollView];
    [self addSwipeGesture];
    
    //// Model
    _model = [[TwitterTimelineViewModel alloc] init];
    _model.delegate = self;
    
    //// Load Statuses
    _params = [[NSRequestParams alloc] init];
    _params.page = 1;
}

- (void)loadStatuses
{
    [_scrollView removeAllSubviews];
    [_model callApi:_api params:_params];
}

//// Delegate
- (void)didLoadStatuses:(NSArray *)statuses
{
    //// Add Header
    UITwitterScrollHeaderView* header = [[UITwitterScrollHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _scrollView.frame.size.width, 44.0f)];
    [header setTitle:_headerTitle page:_params.page];
    [_scrollView appendView:header margin:0.0f];
    
    NSStatus* status;
    for(int index = 0;index < [statuses count];index++){
        status = (NSStatus*)[statuses objectAtIndex:index];
        UIStatusView* view = [[UIStatusView alloc] initWithStatus:status];
        [_scrollView appendView:view];
    }
    _state = TimelineViewStateReady;
    [SVProgressHUD dismiss];
}

- (void)didReturnError:(NSString *)error
{
    _state = TimelineViewStateReady;
}

#pragma mark Paging

- (void)goToNextPage
{
    dlog(@"Go to Next Page.");
    _params.page = _params.page + 1;
    [self loadStatuses];
}

- (void)goToPrevPage
{
    dlog(@"Go to Prev Page.");
    _params.page = _params.page - 1;
    [self loadStatuses];
}

#pragma mark - Swipe Gestures

- (void)addSwipeGesture
{
    //// Right
    UISwipeGestureRecognizer* swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_scrollView addGestureRecognizer:swipeRight];
    
    //// Left
    UISwipeGestureRecognizer* swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_scrollView addGestureRecognizer:swipeLeft];
}

- (void)didSwipeRight:(UISwipeGestureRecognizer *)sender
{
    if(_state == TimelineViewStateReady){
        if(_params.page > 1){
            _state = TimelineViewStateLoadingStatuses;
            [SVProgressHUD showWithStatus:@"前のページ" maskType:SVProgressHUDMaskTypeClear interval:0 addTarget:self selector:@selector(goToPrevPage)];
        }
    }}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)sender
{
    if(_state == TimelineViewStateReady){
        _state = TimelineViewStateLoadingStatuses;
        [SVProgressHUD showWithStatus:@"次のページ" maskType:SVProgressHUDMaskTypeClear interval:0 addTarget:self selector:@selector(goToNextPage)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [_model cleanStatusesCache];
    dlog(@"$$ Memory Warning $$");
    dlog(@"Cleaned cache.");
}

@end
