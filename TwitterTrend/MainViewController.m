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

- (void)awakeFromNib
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //// NavigationBar
    self.tabBarController.navigationItem.title = [NSString stringWithFormat:@"つぶやき（24時間）"];
    
    //// General Decralations
    _api = @"words/popular";
    
    //// Load
    [self loadStatuses];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
