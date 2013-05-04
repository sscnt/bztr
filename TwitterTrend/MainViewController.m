//
//  ViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/01.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.navigationItem.title = [NSString stringWithFormat:@"つぶやきtw（24時間）"];
    
    NSStatus* status = [[NSStatus alloc] init];
    status.text = @"NUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUNUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUNUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
    UIStatusView* view = [[UIStatusView alloc] initWithStatus:status];
    [_scrollView addSubview:view];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
