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
    
    if([_users count] > 0){
        _tableView = [[UISettingsTableView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 0.0f)];
        _tableView.delegate = self;
        [_scrollView appendView:_tableView margin:10];
    }
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

- (void)tableView:(UISettingsTableView *)tableView didCellTapAtIndex:(NSInteger)index
{
    if(_actionSheet == nil){
        _actionSheet = [[UIActionSheet alloc] init];
        _actionSheet.delegate = self;
        _actionSheetButtonIndexForRemoveNonDisplayUser = [_actionSheet addButtonWithTitle:@"非表示を解除"];
        int cancelIndex = [_actionSheet addButtonWithTitle:@"キャンセル"];
        [_actionSheet setCancelButtonIndex:cancelIndex];
    }
    NSFilterUsersFullData* data = [_users objectAtIndex:index];
    _actionSheet.title = [NSString stringWithFormat:@"%@@%@", data.name, data.screen_name];
    _actionSheet.tag = index;
    [_actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == _actionSheetButtonIndexForRemoveNonDisplayUser){
        NSFilterUsersFullData* data = [_users objectAtIndex:actionSheet.tag];
        if(data){
            NSFilter* filter = [NSFilter sharedFilter];
            BOOL success = [filter removeUser:data];
            if(success){
                dlog(@"Removed.");
                [_tableView removeRowAtIndex:actionSheet.tag];
            }else{
                UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
                alert.delegate = nil;
                alert.message = @"問題が発生しました。";
                alert.title = @"エラー";
                int okIndex = [alert addButtonWithTitle:@"OK"];
                [alert setCancelButtonIndex:okIndex];
                [alert show];
            }
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{

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
