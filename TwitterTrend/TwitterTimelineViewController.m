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
    [self showSettingsBtn];
    
    //// Load Enduser Data
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    if(userData.registered == NO){
        dlog(@"DO REGISTERATION NOW!!!!!!");
        UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
        alert.tag = AlertViewIdentifierRegistration;
        alert.delegate = self;
        alert.message = @"アプリ再インストール時に復元できるように、iCloudにユーザー情報を保存しますか？";
        alert.title = @"初期設定";
        int okIndex = [alert addButtonWithTitle:@"しない"];
        [alert setCancelButtonIndex:okIndex];
        [alert addButtonWithTitle:@"保存する"];
        [alert show];
        return;
    } else {
        [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
        [_modelEnduser fetchUser];
    }
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
    [_scrollView removeAllSubviews];
    [_modelStatuses cleanStatusesCache];
    _params = [[NSRequestParams alloc] init];
    _params.page = 1;
    dlog(@"Restart");
}

- (void)loadStatuses
{
    dlog(@"Called API %@", _api);
    [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
    [_scrollView removeAllSubviews];
    [_modelStatuses loadStatusesWithApi:_api params:_params];
}

#pragma mark TwitterTimelineViewStatusesModelDelegate

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
    
    if(_params.page > 1){
        button = [UIFlatButtonCreator createWhiteButtonWithFrame:frame];
        [button addTarget:self action:@selector(goToPrevPageWithProgressHUD) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"前のページへ" forState:UIControlStateNormal];
        [_scrollView appendView:button margin:15.0f];
    }
    
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
    
}

- (void)didClickUserOpenWithButton:(NSStatus *)status
{
    if(_state == TimelineViewStateReady){
        _state = TimelineViewStateActionSheetShowing;
        if(!_sheetUser){
            _sheetUser = [[UIActionSheet alloc] init];
            _sheetUser.delegate = self;
            _sheetUser.tag = ActionSheetTagUser;
            _actionSheetUserButtonIndexOpenWithTwitterApp = [_sheetUser addButtonWithTitle:@"Twitterアプリで開く"];
            _actionSheetUserButtonIndexDeveloperBlock = [_sheetUser addButtonWithTitle:@"ブロック"];
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
        
        //// Developer Block
        if(buttonIndex == _actionSheetUserButtonIndexDeveloperBlock){
            UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
            alert.tag = AlertViewIdentifierDeveloperBlock;
            alert.delegate = self;
            alert.title = @"確認";
            alert.message = @"ブロックしますか？";
            int okIndex = [alert addButtonWithTitle:@"キャンセル"];
            [alert setCancelButtonIndex:okIndex];
            [alert addButtonWithTitle:@"ブロック"];
            [alert show];
            return;
        }
        
        return;
    }
    
    //// Status
    if(actionSheet.tag == ActionSheetTagStatus){
        return;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    _state = TimelineViewStateReady;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //// Developer Block
    if(alertView.tag == AlertViewIdentifierDeveloperBlock){
        if(buttonIndex == 1){            
            [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
            _params.user_id_string = _currentTargetStatus.user.id_string;
            [_modelDeveloper developerBlockWithParams:_params];
        }
        return;
    }
    
    //// Registration
    if(alertView.tag == AlertViewIdentifierRegistration){
        NSEnduserData* userData = [NSEnduserData sharedEnduserData];
        if(buttonIndex == 1){
            userData.iCloudEnabled = YES;
        }
        [self initializeUser];
        return;
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
