//
//  TwitterTabBarController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterTabBarController.h"

@implementation TwitterTabBarController

- (id)init
{
    self = [super init];
    if(self){
        self.tabBar.hidden = YES;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
