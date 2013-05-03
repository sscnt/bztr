//
//  TwitterTabBarController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterTabBarController.h"

@interface TwitterTabBarController ()

@end

@implementation TwitterTabBarController

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
    
    self.tabBar.hidden = YES;
    [self.view setFrame:[UIScreen screenRect]];
    for(UIView *view in self.view.subviews)
    {
        if(![view isKindOfClass:[UITabBar class]])
        {
            [view setHeight:[UIScreen height]];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
