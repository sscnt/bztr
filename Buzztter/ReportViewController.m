//
//  ReportViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    
    _textView = [[UIReportTextView alloc] initWithFrame:CGRectMake(10.0f, 10.0f, [UIScreen screenSize].width - 20.0f, 100.0f)];
    //// AccessoryView
    UIAccessoryView* accessory = [[UIAccessoryView alloc] initWithStyle:UIAccessoryViewButtonPositionRight];
    [accessory addTarget:self action:@selector(closeKeyboard:)];
    _textView.inputAccessoryView = accessory;
    [self.view addSubview:_textView];
    
    UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(10.0f, _textView.bottom + 10.0f, [UIScreen screenSize].width - 20.0f, 40.0f)];
    [button setTitle:@"送信" forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)closeKeyboard:(id)sender
{
    [_textView resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    //// NavigationBar
    self.tabBarController.navigationItem.title = @"ご意見・不具合の報告";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
