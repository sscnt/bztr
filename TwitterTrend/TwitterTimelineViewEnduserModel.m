//
//  TwitterTimelineViewUserModel.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/11.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterTimelineViewEnduserModel.h"

@implementation TwitterTimelineViewEnduserModel

- (id)init
{
    self = [super init];
    if(self){
        _apiForRegistration = [[NSTrendApi alloc] init];
        _apiForRegistration.delegate = self;
        _apiForRegistration.identifier = TwitterTimelineViewEnduserModelApiIdentifierRegistration;
    }
    return self;
}

- (void)registerUser
{
    NSRequestParams* params = [[NSRequestParams alloc] init];
    [_apiForRegistration call:@"enduser/register" params:params];
}

#pragma mark NSTrendApiDelegate

- (void)apiDidReturnError:(NSString *)error WithIdentifier:(NSInteger)identifier
{
    //// Registration
    if(identifier == TwitterTimelineViewEnduserModelApiIdentifierRegistration){
        [self.delegate didRegistrationFailedWithError:error];
        return;
    }
}

- (void)apiDidReturnResult:(NSDictionary *)json WithIdentifier:(NSInteger)identifier
{
    //// Registration
    if(identifier == TwitterTimelineViewEnduserModelApiIdentifierRegistration){
        NSEnduserData* userData = [NSEnduserData sharedEnduserData];
        userData.registered = YES;
        [self.delegate didRegisterUserAndSaved];
        return;
    }
}

@end
