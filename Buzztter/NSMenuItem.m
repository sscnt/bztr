//
//  NSMenuItem.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/06.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSMenuItem.h"

@implementation NSMenuItem

- (id)init
{
    self = [super init];
    if(self){
        self.type = NSMenuItemTypeTimeline;
    }
    return self;
}

@end
