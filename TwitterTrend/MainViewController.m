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
    self.tabBarController.navigationItem.title = [NSString stringWithFormat:@"つぶやき"];
    
    //// General Decralations
    _api = @"images/popular";
    _headerTitle = @"新着順（一般）";
    
    //// Load
    [SVProgressHUD showWithStatus:@"読み込み中" maskType:SVProgressHUDMaskTypeClear];
    [self loadStatuses];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
