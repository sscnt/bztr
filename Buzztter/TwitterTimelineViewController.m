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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wantsFullScreenLayout = YES;
    _filterViewState = FilterViewStateHidden;
    _params = [[NSRequestParams alloc] init];
    _nextPageExists = YES;
    
    //// Model
    _modelStatuses = [[TwitterTimelineViewStatusesModel alloc] init];
    _modelStatuses.delegate = self;
    _modelDeveloper = [[TwitterTimelineViewDeveloperModel alloc] init];
    _modelDeveloper.delegate = self;
    _modelEnduser = [[TwitterTimelineViewEnduserModel alloc] init];
    _modelEnduser.delegate = self;
    
    //// View    
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    UITwitterBackgroundView* bg = [[UITwitterBackgroundView alloc] init];
    [self.view addSubview:bg];
    [self showMenuBtn];
    
    //// Load Enduser Data
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    if(userData.registered == NO){
        [_modelEnduser registerUser];
    } else {
        [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
        [_modelEnduser fetchUser];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showSettingsBtn];
}

- (void)initializeController
{

    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, [UIScreen screenSize].height - 64.0f)];
    [self.view addSubview:_scrollView];

    [self addSwipeGesture];
    
    [self restart];    
    
    //// NavigationBar
    self.navigationBarTitle = @"つぶやき";
    
    //// General Decralations
    self.api = @"words/popular";
    self.headerTitle = @"新着順（一般）";
    
    //// Load
    [self loadStatuses];
}

- (void)initializeUser
{
    [SVProgressHUD showWithStatus:@"初期設定中..." maskType:SVProgressHUDMaskTypeClear];
    [_modelEnduser registerUser];
}

- (void)didInitializeUser
{
    [SVProgressHUD dismiss];
    [self initializeController];
}

- (void)setNavigationBarTitle:(NSString *)navigationBarTitle
{
    self.tabBarController.navigationItem.title = navigationBarTitle;
}

- (void)restart
{
    _nextPageExists = YES;
    [_scrollView removeAllSubviews];
    _scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    _filterViewState = FilterViewStateHidden;
    _state = TimelineViewStateReady;
    [_modelStatuses cleanStatusesCache];
    _params.page = 1;
}

- (void)loadStatuses
{
    _nextPageExists = YES;
    dlog(@"Called API %@", _api);
    [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
    [_scrollView removeAllSubviews];
    [_modelStatuses loadStatusesWithApi:_api params:_params];
}

- (void)showFilterView
{
    FilterViewController* controller  = [[FilterViewController alloc] init];
    controller.params = _params;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark TwitterTimelineViewStatusesModelDelegate

- (void)didLoadStatusesButEmpty
{
    _nextPageExists = NO;
    //// General Decralations
    CGFloat viewWidth = _scrollView.frame.size.width - 20.0f;
    CGFloat viewX = 10.0f;
    CGFloat paddingX = 16.0f;
    CGFloat paddingWidth = viewWidth - 12.0f;
    
    //// Add Header
    UITwitterScrollHeaderView* header = [[UITwitterScrollHeaderView alloc] initWithFrame:CGRectMake(viewX, 0.0f, viewWidth, 44.0f)];
    [header setTitle:_headerTitle page:_params.page];
    [_scrollView appendView:header margin:4.0f];
    
    //// Label
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(viewX, 0.0f, viewWidth, [UIScreen screenSize].height - 108.0f)];
    label.text = @"見つかりませんでした";
    label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:18.0f];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [_scrollView appendView:label margin:10.0f];
    
    //// Insert Buttons
    CGRect frame = CGRectMake(paddingX, 0.0f, paddingWidth, 34.0f);
    UIFlatBUtton* button;
    
    if(_params.page > 1){
        button = [UIFlatButtonCreator createWhiteButtonWithFrame:frame];
        [button addTarget:self action:@selector(goToPrevPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"前のページへ" forState:UIControlStateNormal];
        [_scrollView appendView:button margin:15.0f];
        
        button = [UIFlatButtonCreator createWhiteButtonWithFrame:frame];
        [button addTarget:self action:@selector(goToTopPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"最初のページへ" forState:UIControlStateNormal];
        [_scrollView appendView:button margin:15.0f];
    }
    
    
    _state = TimelineViewStateReady;
    [SVProgressHUD dismiss];
}


- (void)didLoadStatusesButReachedToLimit
{
    _nextPageExists = NO;
    //// General Decralations
    CGFloat viewWidth = _scrollView.frame.size.width - 20.0f;
    CGFloat viewX = 10.0f;
    CGFloat paddingX = 16.0f;
    CGFloat paddingWidth = viewWidth - 12.0f;
    
    //// Add Header
    UITwitterScrollHeaderView* header = [[UITwitterScrollHeaderView alloc] initWithFrame:CGRectMake(viewX, 0.0f, viewWidth, 44.0f)];
    [header setTitle:_headerTitle page:_params.page];
    [_scrollView appendView:header margin:4.0f];
    
    //// Label
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(paddingX, 0.0f, viewWidth - 10.0f, 0.0f)];
    label.text = @"プレミアム機能を購入すればすべてのページを見ることができます。";
    label.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:16.0f];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat margin = [UIScreen screenRect].size.height / 2.0f - 130.0f;
    [_scrollView appendView:label margin:margin];
    
    //// Button
    UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(paddingX, 0.0f, viewWidth - 10.0f, 40.0f)];
    [button setTitle:@"プレミアム機能について" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(presentToPremium) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView appendView:button margin:10.0f];
    
    //// Insert Buttons
    CGRect frame = CGRectMake(paddingX, 0.0f, paddingWidth, 34.0f);
    
    if(_params.page > 1){
        margin = [UIScreen screenRect].size.height / 2.0f - 90.0f;
        button = [UIFlatButtonCreator createWhiteButtonWithFrame:frame];
        [button addTarget:self action:@selector(goToPrevPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"前のページへ" forState:UIControlStateNormal];
        [_scrollView appendView:button margin:margin];
        
        button = [UIFlatButtonCreator createWhiteButtonWithFrame:frame];
        [button addTarget:self action:@selector(goToTopPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"最初のページへ" forState:UIControlStateNormal];
        [_scrollView appendView:button margin:15.0f];
    }
    
    
    _state = TimelineViewStateReady;
    [SVProgressHUD dismiss];
}

- (void)presentToPremium
{
    [self showPremium];
}

- (void)didLoadStatuses:(NSArray *)statuses
{
    _nextPageExists = YES;
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
    
    if(_params.page > 1){
        button = [UIFlatButtonCreator createWhiteButtonWithFrame:frame];
        [button addTarget:self action:@selector(goToPrevPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"前のページへ" forState:UIControlStateNormal];
        [_scrollView appendView:button margin:15.0f];
        
        button = [UIFlatButtonCreator createWhiteButtonWithFrame:frame];
        [button addTarget:self action:@selector(goToTopPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"最初のページへ" forState:UIControlStateNormal];
        [_scrollView appendView:button margin:15.0f];

    }
    _state = TimelineViewStateReady;
    [SVProgressHUD dismiss];
}

- (void)didReturnError:(NSString *)error
{
    _state = TimelineViewStateReady;
    [_modelStatuses cleanStatusesCache];
    [SVProgressHUD dismiss];
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = nil;
    alert.message = error;
    alert.title = @"エラー";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
}

- (void)didFailToPrepareFilter
{
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = nil;
    alert.message = @"フィルター機能の初期化に失敗しました。";
    alert.title = @"エラー";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
}

#pragma mark TwitterTimelineViewUsersModelDelegate

- (void)didFinishDeveloperBlockingWithMessage:(NSString *)message
{
    [SVProgressHUD dismiss];
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = nil;
    alert.message = message;
    alert.title = @"ブロック";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
}

#pragma mark TwitterTimelineViewEndsersModelDelegate

- (void)didRegisterUserAndSaved
{
    [self didInitializeUser];
}

- (void)didFailToRegisterWithError:(NSString *)error
{
    [SVProgressHUD dismiss];
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = nil;
    alert.message = error;
    alert.title = @"エラー";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
}

- (void)didFetchUserData
{
    [self initializeController];
}

- (void)didFetchUserDataWithAnnouncement:(NSString *)announcement
{
    [SVProgressHUD dismiss];
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = self;
    alert.tag = AlertViewIdentifierFetchingAnnouncement;
    alert.message = announcement;
    alert.title = @"お知らせ";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
}

- (void)didFailToFetchUserDataWithError:(NSString *)error
{
    [SVProgressHUD dismiss];
    UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
    alert.delegate = nil;
    alert.message = error;
    alert.title = @"エラー";
    int okIndex = [alert addButtonWithTitle:@"OK"];
    [alert setCancelButtonIndex:okIndex];
    [alert show];
}

#pragma mark Paging

- (void)goToNextPage
{
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    dlog(@"Go to Next Page.");
    _params.page = _params.page + 1;
    if(userData.premium == NO && _params.page > StandardPageLimit){
        [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
        [_scrollView removeAllSubviews];
        [self didLoadStatusesButReachedToLimit];
        return;
    }
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
    if(_state == TimelineViewStateReady){
        [self goToPrevPageWithProgressHUD];
    }
}

- (void)didSwipeLeft:(UISwipeGestureRecognizer *)sender
{
    if(_state == TimelineViewStateReady && _nextPageExists){
        [self goToNextPageWithProgressHUD];
    }
}


#pragma mark UIStatusViewDelegate

- (void)didClickImage:(UIImage *)image status:(NSStatus *)status
{
    //// Animation
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;
    
    //// Viewcontroller
    ImageZoomViewController* controller = [[ImageZoomViewController alloc] init];
    controller.image = image;
    controller.status = status;
    
    //// Push
    [self.tabBarController.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.tabBarController.navigationController pushViewController:controller animated:NO];
}

- (void)didClickStatusOpenWithButton:(NSStatus *)status
{
    if(_state == TimelineViewStateReady){
        _state = TimelineViewStateActionSheetShowing;
        if(!_sheetStatus){
            _sheetStatus = [[UIActionSheet alloc] init];
            _sheetStatus.delegate = self;
            _sheetStatus.tag = ActionSheetTagStatus;
            _actionSheetStatusButtonIndexOpenWithTwitterApp = [_sheetStatus addButtonWithTitle:@"Twitterアプリで開く"];
            _actionSheetStatusButtonIndexCopyUrl = [_sheetStatus addButtonWithTitle:@"URLをコピー"];
            _actionSheetStatusButtonIndexOpenWithSafari = [_sheetStatus addButtonWithTitle:@"Safariで開く"];
            _actionSheetStatusButtonIndexOpenWithChrome = [_sheetStatus addButtonWithTitle:@"Chromeで開く"];
            _actionSheetStatusButtonIndexCancel = [_sheetStatus addButtonWithTitle:@"キャンセル"];
            [_sheetStatus setCancelButtonIndex:_actionSheetStatusButtonIndexCancel];
        }
        _sheetStatus.title = [NSString stringWithFormat:@"http://twitter.com/%@/statuses/%@", status.user.screen_name, status.id_string];
        _currentTargetStatus = status;
        [_sheetStatus showInView:self.view];
    }
}

- (void)didClickUserOpenWithButton:(NSStatus *)status
{
    if(_state == TimelineViewStateReady){
        _state = TimelineViewStateActionSheetShowing;
        if(!_sheetUser){
            NSEnduserData* userData = [NSEnduserData sharedEnduserData];
            _sheetUser = [[UIActionSheet alloc] init];
            _sheetUser.delegate = self;
            _sheetUser.tag = ActionSheetTagUser;
            _actionSheetUserButtonIndexOpenWithTwitterApp = [_sheetUser addButtonWithTitle:@"Twitterアプリで開く"];
            if(userData.premium){
                _actionSheetUserButtonIndexPremiumHide = [_sheetUser addButtonWithTitle:@"非表示にする"];
            }
            _actionSheetUserButtonIndexCancel = [_sheetUser addButtonWithTitle:@"キャンセル"];
            [_sheetUser setCancelButtonIndex:_actionSheetUserButtonIndexCancel];
        }
        _sheetUser.title = [NSString stringWithFormat:@"%@ @%@", status.user.name, status.user.screen_name];
        _currentTargetStatus = status;
        [_sheetUser showInView:self.view];
    }
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //// User
    if(actionSheet.tag == ActionSheetTagUser){
        
        //// Open With Twitter App
        if(buttonIndex == _actionSheetUserButtonIndexOpenWithTwitterApp){            
            NSString* urlString = [NSString stringWithFormat:@"twitter://user?id=%@", _currentTargetStatus.user.id_string];
            NSURL *url = [NSURL URLWithString:urlString];
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:NO];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            } else {
                UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
                alert.delegate = nil;
                alert.message = @"URLを開けません";
                alert.title = @"エラー";
                int okIndex = [alert addButtonWithTitle:@"OK"];
                [alert setCancelButtonIndex:okIndex];
                [alert show];
            }
        
            return;
        }
        
        //// Hide
        if(buttonIndex == _actionSheetUserButtonIndexPremiumHide){
            UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
            alert.tag = AlertViewIdentifierHideUser;
            alert.delegate = self;
            alert.title = @"確認";
            alert.message = @"非表示にしますか？";
            int okIndex = [alert addButtonWithTitle:@"キャンセル"];
            [alert setCancelButtonIndex:okIndex];
            [alert addButtonWithTitle:@"OK"];
            [alert show];
            return;
        }
        
        return;
    }
    
    //// Status
    if(actionSheet.tag == ActionSheetTagStatus){
        //// Open With Twitter App
        if(buttonIndex == _actionSheetStatusButtonIndexOpenWithTwitterApp){
            NSString* urlString = [NSString stringWithFormat:@"twitter://status?id=%@", _currentTargetStatus.id_string];
            NSURL *url = [NSURL URLWithString:urlString];
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:NO];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            } else {
                UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
                alert.delegate = nil;
                alert.message = @"URLを開けません";
                alert.title = @"エラー";
                int okIndex = [alert addButtonWithTitle:@"OK"];
                [alert setCancelButtonIndex:okIndex];
                [alert show];
            }
            return;
        }
        
        //// Copy URL
        if(buttonIndex == _actionSheetStatusButtonIndexCopyUrl){
            UIPasteboard *board = [UIPasteboard generalPasteboard];
            [board setValue:[NSString stringWithFormat:@"https://twitter.com/%@/statuses/%@", _currentTargetStatus.user.screen_name, _currentTargetStatus.id_string] forPasteboardType:@"public.utf8-plain-text"];
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:NO];
            UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
            alert.delegate = nil;
            alert.message = @"コピーしました";
            alert.title = @"";
            int okIndex = [alert addButtonWithTitle:@"OK"];
            [alert setCancelButtonIndex:okIndex];
            [alert show];
            return;

            return;
        }
        
        //// Open With Safari
        if(buttonIndex == _actionSheetStatusButtonIndexOpenWithSafari){
            NSString* urlString = [NSString stringWithFormat:@"https://twitter.com/%@/statuses/%@", _currentTargetStatus.user.screen_name, _currentTargetStatus.id_string];
            NSURL *url = [NSURL URLWithString:urlString];
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:NO];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            } else {
                UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
                alert.delegate = nil;
                alert.message = @"URLを開けません";
                alert.title = @"エラー";
                int okIndex = [alert addButtonWithTitle:@"OK"];
                [alert setCancelButtonIndex:okIndex];
                [alert show];
            }
            return;
        }
        
        //// Open With Chrome
        if(buttonIndex == _actionSheetStatusButtonIndexOpenWithChrome){
            NSString* urlString = [NSString stringWithFormat:@"googlechrome://twitter.com/%@/statuses/%@", _currentTargetStatus.user.screen_name, _currentTargetStatus.id_string];
            NSURL *url = [NSURL URLWithString:urlString];
            [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:NO];
            
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            } else {
                UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
                alert.delegate = nil;
                alert.message = @"URLを開けません";
                alert.title = @"エラー";
                int okIndex = [alert addButtonWithTitle:@"OK"];
                [alert setCancelButtonIndex:okIndex];
                [alert show];
            }
            return;
            return;
        }
        return;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    _state = TimelineViewStateReady;
}

#pragma mark UIFilterViewDelegate

- (void)filterDidApply:(BOOL)didChangeOnlyPage
{
    [_modelStatuses cleanStatusesCache];
    if(!didChangeOnlyPage){
        _params.page = 1;
    }
    if(_params.page == 0){
        _params.page = 1;
    }
    
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    if(userData.premium == NO && _params.page > StandardPageLimit){
        _params.page = StandardPageLimit;
        [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
        [_scrollView removeAllSubviews];
        [self didLoadStatusesButReachedToLimit];
        return;

    }
    _scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    _filterViewState = FilterViewStateHidden;
    [self loadStatuses];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //// When Hidden
    if(_filterViewState == FilterViewStateHidden){
        if(scrollView.contentOffset.y < -120.0f){
            scrollView.contentInset = UIEdgeInsetsMake(330.0f, 0.0f, 0.0f, 0.0f);
            _filterViewState = FilterViewStateDisplay;
            _state = TimelineViewStateSettingMinMax;
        }
        return;
    }
    
    //// when Display
    if(_filterViewState == FilterViewStateDisplay){
        if(scrollView.contentOffset.y > 0.0f){
            scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
            _filterViewState = FilterViewStateHidden;
            _state = TimelineViewStateReady;
        }
        return;
    }
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    
    //// Hide User
    if(alertView.tag == AlertViewIdentifierHideUser){
        if(buttonIndex == 1){
            NSFilter* filter = [NSFilter sharedFilter];
            BOOL success = [filter insertUserInStastus:_currentTargetStatus];
            if(success){
                [_modelStatuses cleanStatusesCache];
                [self loadStatuses];
            } else {
                UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
                alert.delegate = self;
                alert.title = @"エラー";
                alert.message = @"データベースエラー";
                int okIndex = [alert addButtonWithTitle:@"OK"];
                [alert setCancelButtonIndex:okIndex];
                [alert show];                
            }
        }
        return;

    }
    
    //// Registration
    if(alertView.tag == AlertViewIdentifierRegistration){
        //// Deleted
    }
    
    //// Fetching Announcement
    if(alertView.tag == AlertViewIdentifierFetchingAnnouncement){
        [self initializeController];
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [_modelStatuses cleanStatusesCache];
    dlog(@"$$ Memory Warning $$");
    dlog(@"Cleaned cache.");
}

- (void)dealloc
{
    if(_sheetUser){
        _sheetUser.delegate = nil;
    }
    if(_sheetStatus){
        _sheetStatus.delegate = nil;
    }
    _modelStatuses.delegate = nil;
    _modelDeveloper.delegate = nil;
}

@end
