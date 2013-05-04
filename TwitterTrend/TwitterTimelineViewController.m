//
//  UITimelineViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterTimelineViewController.h"

@interface TwitterTimelineViewController ()

@end

@implementation TwitterTimelineViewController

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
    
    self.view.backgroundColor = [UIColor timelineBackgroundColorPrimary];
    UITwitterBackgroundView* bg = [[UITwitterBackgroundView alloc] init];
    [self.view addSubview:bg];
    [self showMenuBtn];
    [self showSettingsBtn];
    
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [UIScreen screenSize].width - 20.0f, self.view.frame.size.height - 44.0f)];
    [self.view addSubview:_scrollView];
}

- (void)didLoadStatuses:(NSArray*)statuses
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
