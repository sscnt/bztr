//
//  TwitterTimelineViewUsersModel.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/11.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterTimelineViewDeveloperModel.h"

@implementation TwitterTimelineViewDeveloperModel

- (id)init
{
    self = [super init];
    if(self){
        _api = [[NSTrendApi alloc] init];
        _api.delegate = self;
    }
    return self;
}

- (void)developerBlockWithParams:(NSRequestParams *)params
{
    [_api call:@"developer/block" params:params];
}

#pragma mark NSTrendApiDelegate

- (void)apiDidReturnError:(NSString*)error
{
    [self.delegate didReturnError:error];
}

- (void)apiDidReturnResult:(NSDictionary*)json
{
    [self.delegate didFinishDeveloperBlockingWithMessage:[json objectForKey:@"message"]];
}

- (void)dealloc
{
    self.delegate = nil;
}

@end
