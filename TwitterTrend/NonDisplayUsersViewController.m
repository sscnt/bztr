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

    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"非表示中のユーザー";
    label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16];
    label.backgroundColor = [UIColor clearColor];
    [label setX:15];
    [label sizeToFit];
    [_scrollView appendView:label margin:15.0f];
    
    _tableView = [[UISettingsTableView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 400.0f)];
    _tableView.delegate = self;
    [_scrollView appendView:_tableView margin:10];
    
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
    NSFilterUsersFullData* data = [_users objectAtIndex:index];
    UISettingsTableViewCell* cell = [[UISettingsTableViewCell alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 50.0f)];
    cell.text = data.name;
    cell.detailText = [NSString stringWithFormat:@"@%@", data.screen_name];
    if(index == 0){
        cell.position = CellPositionTop;
    } else if (index == [_users count] - 1){
        cell.position = CellPositionBottom;
    }
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
