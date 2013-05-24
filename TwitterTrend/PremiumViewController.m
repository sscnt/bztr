//
//  PremiumViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "PremiumViewController.h"

@interface PremiumViewController ()

@end

@implementation PremiumViewController

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
    
    //// NavigationBar
    self.tabBarController.navigationItem.title = @"プレミアムサービス";
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, [UIScreen screenRect].size.height - 64.0f)];
    
    UILabel* label;
    label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 20.0f)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:15.0f];
    label.text = @"";
    [label sizeToFit];
    [_scrollView appendView:label margin:20.0f];
    
    UIFlatBUtton* button = [UIFlatButtonCreator createBlackButtonWithFrame:CGRectMake(20.0f, 0.0f, [UIScreen screenSize].width - 40.0f, 40.0f)];
    [button setTitle:@"¥450/30日" forState:UIControlStateNormal];
    [_scrollView appendView:button margin:20.0f];
    
    [self.view addSubview:_scrollView];
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
