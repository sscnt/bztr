//
//  TwitterNavigationController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterNavigationController.h"

@implementation TwitterNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBarBg"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor clearColor]];
    
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(-6.0, 0.0, 332.0, self.navigationBar.frame.size.height + 1.0)];
    [rectanglePath closePath];
    
    self.navigationBar.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.navigationBar.layer.shadowRadius = 1.0f;
    self.navigationBar.layer.shadowPath = rectanglePath.CGPath;
    self.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationBar.layer.shadowOpacity = 0.4f;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
