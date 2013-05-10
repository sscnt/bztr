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
    
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, self.view.frame.size.height - 44.0f)];
    [self.view addSubview:_scrollView];
    [self addSwipeGesture];
    
    //// Model
    _model = [[TwitterTimelineViewModel alloc] init];
    _model.delegate = self;
    
    [self restart];    
    
    //// NavigationBar
    self.navigationBarTitle = @"つぶやき";
    
    //// General Decralations
    self.api = @"words/popular";
    self.headerTitle = @"新着順（一般）";
    
    //// Load
    [self loadStatuses];


}

- (void)setNavigationBarTitle:(NSString *)navigationBarTitle
{
    self.tabBarController.navigationItem.title = navigationBarTitle;
}

- (void)restart
{
    [_scrollView removeAllSubviews];
    [_model cleanStatusesCache];
    _params = [[NSRequestParams alloc] init];
    _params.page = 1;
    dlog(@"Restart");
}

- (void)loadStatuses
{
    dlog(@"Called API %@", _api);
    [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
    [_scrollView removeAllSubviews];
    [_model callApi:_api params:_params];
}

//// Delegate
- (void)didLoadStatuses:(NSArray *)statuses
{
    //// General Decralations
    CGFloat viewWidth = _scrollView.frame.size.width - 20.0f;
    CGFloat viewX = 10.0f;
    CGFloat paddingX = 16.0f;
    CGFloat paddingWidth = viewWidth - 12.0f;
    //// Add Header
    UITwitterScrollHeaderView* header = [[UITwitterScrollHeaderView alloc] initWithFrame:CGRectMake(viewX, 0.0f, viewWidth, 44.0f)];
    [header setTitle:_headerTitle page:_params.page];
    [_scrollView appendView:header margin:4.0f];
    
    //// Insert Statuses
    NSStatus* status;
    for(int index = 0;index < [statuses count];index++){
        status = (NSStatus*)[statuses objectAtIndex:index];
        UIStatusView* view = [[UIStatusView alloc] initWithStatus:status];
        view.delegate = self;
        [_scrollView appendView:view];
    }
    
    //// Insert Buttons
    CGRect frame = CGRectMake(paddingX, 0.0f, paddingWidth, 34.0f);
    UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:frame];
    [button addTarget:self action:@selector(goToNextPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"次のページへ" forState:UIControlStateNormal];    
    [_scrollView appendView:button margin:20.0f];
    
    button = [UIFlatButtonCreator createWhiteButtonWithFrame:frame];
    [button addTarget:self action:@selector(goToPrevPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"前のページへ" forState:UIControlStateNormal];
    [_scrollView appendView:button margin:15.0f];
    
    button = [UIFlatButtonCreator createWhiteButtonWithFrame:frame];
    [button addTarget:self action:@selector(goToTopPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"最初のページへ" forState:UIControlStateNormal];
    [_scrollView appendView:button margin:15.0f];
    
    _state = TimelineViewStateReady;
    [SVProgressHUD dismiss];
}

- (void)didReturnError:(NSString *)error
{
    _state = TimelineViewStateReady;
    [SVProgressHUD dismiss];
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

- (void)goToTopPage
{
    dlog(@"Go to Top Page.");
    _params.page = 1;
    [self loadStatuses];
}

- (void)goToNextPageWithProgressHUD
{
    if(_state == TimelineViewStateReady){
        _state = TimelineViewStateLoadingStatuses;
        [SVProgressHUD showWithStatus:@"次のページ" maskType:SVProgressHUDMaskTypeClear interval:0 addTarget:self selector:@selector(goToNextPage)];
    }
}

- (void)goToPrevPageWithProgressHUD
{    
    if(_state == TimelineViewStateReady){
        if(_params.page > 1){
            _state = TimelineViewStateLoadingStatuses;
            [SVProgressHUD showWithStatus:@"前のページ" maskType:SVProgressHUDMaskTypeClear interval:0 addTarget:self selector:@selector(goToPrevPage)];
        }
    }
}

- (void)goToTopPageWithProgressHUD
{
    if(_state == TimelineViewStateReady){
        _state = TimelineViewStateLoadingStatuses;
        [SVProgressHUD showWithStatus:@"最初のページ" maskType:SVProgressHUDMaskTypeClear interval:0 addTarget:self selector:@selector(goToTopPage)];
    }
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
    [self goToPrevPageWithProgressHUD];
}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)sender
{
    [self goToNextPageWithProgressHUD];
}


#pragma mark UIStatusViewDelegate
- (void)didClickImage:(UIImage *)image
{
    //// Animation
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;
    
    //// Viewcontroller
    ImageZoomViewController* controller = [[ImageZoomViewController alloc] init];
    controller.image = image;
    
    //// Push
    [self.tabBarController.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.tabBarController.navigationController pushViewController:controller animated:NO];
}

- (void)didClickStatusOpenWithButton:(NSStatus *)status
{
    
}

- (void)didClickUserOpenWithButton:(NSStatus *)status
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [_model cleanStatusesCache];
    dlog(@"$$ Memory Warning $$");
    dlog(@"Cleaned cache.");
}

@end
