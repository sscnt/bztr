//
//  NGWordViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NGWordViewController.h"

@interface NGWordViewController ()

@end

@implementation NGWordViewController

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
    [self showBackButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
