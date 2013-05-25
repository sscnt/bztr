//
//  NonDisplayUsersViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NonDisplayUsersViewController.h"

@interface NonDisplayUsersViewController ()

@end

@implementation NonDisplayUsersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSFilter* filter = [NSFilter sharedFilter];
        _users = [filter getHiddenUsersFullData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"設定";
    
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    [self showBackButton];
    
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, [UIScreen screenSize].height - 64.0f)];

    _tableView = [[UISettingsTableView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 400.0f)];
    _tableView.delegate = self;
    [_scrollView appendView:_tableView margin:20];
    
    [self.view addSubview:_scrollView];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfRowsInTableView:(UISettingsTableView *)tableView
{
    if(_users){
        return [_users count];
    }
    return 0;
}

- (UISettingsTableViewCell*)tableView:(UISettingsTableView *)tableView cellForRowAtIndex:(NSInteger)index
{
    UISettingsTableViewCell* cell = [[UISettingsTableViewCell alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 40.0f)];
    cell.text = @"Text";
    cell.detailText = @"Detail";
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    _tableView.delegate = nil;
}

@end
