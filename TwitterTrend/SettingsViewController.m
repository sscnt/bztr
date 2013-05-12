//
//  SettingsViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    [self showSettingsBtn];
    [self showMenuBtn];
    
    //// NavigationBar
    self.tabBarController.navigationItem.title = @"設定";
    
    DCRoundSwitch* iCloudSwitch = [[DCRoundSwitch alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 70.0f, 26.0f)];
    iCloudSwitch.onText = @"ON";
    iCloudSwitch.offText = @"OFF";
    iCloudSwitch.onTintColor = [UIColor colorWithWhite:56.0f/255.0f alpha:1.0f];
    [self.view addSubview:iCloudSwitch];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
