//
//  TwitterNavigationController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterNavigationController.h"

@interface TwitterNavigationController ()

@end

@implementation TwitterNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor navigationBarBackgroundColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor navigationBarBackgroundColor]];
    
    
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:CGRectMake(-6.0, 0.0, 332.0, self.navigationBar.frame.size.height + 3.0)];
    [rectanglePath closePath];
    
    self.navigationBar.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.navigationBar.layer.shadowRadius = 1.5f;
    self.navigationBar.layer.shadowPath = rectanglePath.CGPath;
    self.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationBar.layer.shadowOpacity = 0.2f;

}

@end
