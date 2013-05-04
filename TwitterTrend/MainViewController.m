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

    //// Model
    _model = [[TwitterTimelineViewModel alloc] init];
    _model.delegate = self;
    
    //// Load Statuses
    NSRequestParams* params = [[NSRequestParams alloc] init];
    params.page = 1;
    [_model callApi:@"words/popular" params:params]; 
}

//// Delegate
- (void)didLoadStatuses:(NSArray *)statuses
{
    dlog(@"Loaded Statuses.");
    NSStatus* status;
    for(int index = 0;index < [statuses count];index++){
        status = (NSStatus*)[statuses objectAtIndex:index];
        UIStatusView* view = [[UIStatusView alloc] initWithStatus:status];
        [_scrollView appendView:view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
