//
//  NonDisplayUsersViewController.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+twitter.h"
#import "UIViewController+navi.h"
#import "NSFilter.h"

@interface NonDisplayUsersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* _users;
}

@end
