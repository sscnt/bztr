//
//  TwitterTimelineViewUsersModel.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/11.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterTimelineViewUsersModel.h"

@implementation TwitterTimelineViewUsersModel

- (void)developerBlockWithParams:(NSRequestParams *)params
{
    
}

#pragma mark NSTrendApiDelegate

- (void)apiDidReturnError:(NSString*)error
{
    [self.delegate didReturnError:error];
}

- (void)apiDidReturnResult:(NSDictionary*)json
{
    [self.delegate didFinishDeveloperBlockingWithMessage:@"UNKO"];
}
@end
