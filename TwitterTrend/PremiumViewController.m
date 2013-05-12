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
}

- (void)viewWillAppear:(BOOL)animated
{
    //// NavigationBar
    self.tabBarController.navigationItem.title = @"プレミアムサービス";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
