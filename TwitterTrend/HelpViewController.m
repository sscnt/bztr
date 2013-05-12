//
//  HelpViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

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
    self.tabBarController.navigationItem.title = @"使い方";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
