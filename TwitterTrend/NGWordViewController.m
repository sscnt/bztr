//
//  NGWordViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NGWordViewController.h"

@interface NGWordViewController ()

@end

@implementation NGWordViewController

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
    _words = [NSMutableArray array];
    
    self.navigationItem.title = @"NGワード";
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    [self showBackButton];
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, [UIScreen screenSize].height - 64.0f)];
    [self.view addSubview:_scrollView];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"追加する";
    label.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16];
    label.backgroundColor = [UIColor clearColor];
    [label setX:15];
    [label sizeToFit];
    [_scrollView appendView:label margin:15.0f];
    
    CGFloat buttonWidth = 80.0f;
    CGFloat textFieldWidth = [UIScreen screenSize].width - 20.0f - buttonWidth;
    
    UIView* wrapper = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 36.0f)];
    _textField = [[UISettingsTextField alloc] initWithFrame:CGRectMake(10.0f, 0.0f, textFieldWidth, 36.0f)];
    
    //// AccessoryView
    UIAccessoryView* accessory = [[UIAccessoryView alloc] initWithStyle:UIAccessoryViewButtonPositionRight];
    [accessory addTarget:self action:@selector(closeKeyboard:)];
    _textField.inputAccessoryView = accessory;
    
    [wrapper addSubview:_textField];
    
    UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(_textField.right + 5.0f, 0.0f, buttonWidth, 35.0f)];
    [button setTitle:@"追加" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickAddButton) forControlEvents:UIControlEventTouchUpInside];
    [wrapper addSubview:button];
    
    _labelForList = [[UILabel alloc] initWithFrame:CGRectZero];
    _labelForList.text = @"登録中のNGワード";
    _labelForList.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16];
    _labelForList.backgroundColor = [UIColor clearColor];
    [_labelForList setX:15];
    [_labelForList sizeToFit];
    [_scrollView appendView:_labelForList margin:15.0f];
    
    [_scrollView appendView:wrapper margin:10.0f];
    
    
    [self layout];
}

- (void)layout
{
    if(_tableView){
        [_tableView removeFromSuperview];
        _tableView.delegate = nil;
        _tableView = nil;
    }
    [_words removeAllObjects];
    NSFilter* filter = [NSFilter sharedFilter];
    _words = [filter getNGWords];
    if([_words count] > 0){
        
        _tableView = [[UISettingsTableView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, 0.0f)];
        _tableView.delegate = self;
        [_scrollView appendView:_tableView margin:10];
    }
}

- (void)didClickAddButton
{
    [self addNGWord:_textField.text];
}

- (void)addNGWord:(NSString *)word
{
    BOOL success = NO;
    if(word.length == 0){

    }else{
        NSFilter* filter = [NSFilter sharedFilter];
        success = [filter insertNGWord:word];
    }
    if(success){
        [self layout];
    }else{
        UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
        alert.delegate = nil;
        alert.message = @"追加できません。";
        alert.title = @"エラー";
        int okIndex = [alert addButtonWithTitle:@"OK"];
        [alert setCancelButtonIndex:okIndex];
        [alert show];
    }

}

- (void)closeKeyboard:(id)sender
{
    [_textField resignFirstResponder];
}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfRowsInTableView:(UISettingsTableView *)tableView
{
    if(_words){
        return [_words count];
    }
    return 0;
}

- (UISettingsTableViewCell*)tableView:(UISettingsTableView *)tableView cellForRowAtIndex:(NSInteger)index
{
    NSFilterWordsFullData* data = [_words objectAtIndex:index];
    UISettingsTableViewCell* cell = [[UISettingsTableViewCell alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.frame.size.width, 34.0f)];
    cell.text = data.word;
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
    NSFilterWordsFullData* data = [_words objectAtIndex:index];
    _actionSheet.title = [NSString stringWithFormat:@"%@", data.word];
    _actionSheet.tag = index;
    [_actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == _actionSheetButtonIndexForRemoveNonDisplayUser){
        NSFilterWordsFullData* data = [_words objectAtIndex:actionSheet.tag];
        if(data){
            NSFilter* filter = [NSFilter sharedFilter];
            BOOL success = [filter removeWord:data];
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

@end
