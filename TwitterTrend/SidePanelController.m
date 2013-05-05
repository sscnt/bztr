//
//  SidePanelController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "SidePanelController.h"

@implementation SidePanelController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor navigationBarBackgroundColor]];
    self.recognizesPanGesture = NO;
    
    
    //// Set Controllers
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"]];
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"]];
}

@end
