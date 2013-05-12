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
        
        _apiForFetchingUserData = [[NSTrendApi alloc] init];
        _apiForFetchingUserData.delegate = self;
        _apiForFetchingUserData.identifier = TwitterTimelineViewEnduerModelApiIdentifierFetchingUserData;
    }
    return self;
}

#pragma mark Registration

- (void)registerUser
{
    NSRequestParams* params = [[NSRequestParams alloc] init];
    [_apiForRegistration call:@"enduser/register" params:params];
}

#pragma mark Fetcing

- (void)fetchUser
{
    NSRequestParams* params = [[NSRequestParams alloc] init];
    NSEnduserData* userData = [NSEnduserData sharedEnduserData];
    params.user_id_string = [NSString stringWithFormat:@"%d", userData.user_id];
    params.user_token = userData.user_token;
    params.user_token_secret = userData.user_token_secret;
    [_apiForFetchingUserData call:@"enduser/fetch" params:params];
}

#pragma mark NSTrendApiDelegate

- (void)apiDidReturnError:(NSString *)error WithIdentifier:(NSInteger)identifier
{
    //// Registration
    if(identifier == TwitterTimelineViewEnduserModelApiIdentifierRegistration){
        [self.delegate didFailToRegisterWithError:error];
        return;
    }
}

- (void)apiDidReturnResult:(NSDictionary *)json WithIdentifier:(NSInteger)identifier
{
    //// Registration
    if(identifier == TwitterTimelineViewEnduserModelApiIdentifierRegistration){
        NSEnduserData* userData = [NSEnduserData sharedEnduserData];
        
        //// Check JSON
        NSEnduserRegistration* registration = [[NSEnduserRegistration alloc] initWithJsonObject:json];
        if(registration.user_id == 0 || registration.user_token.length == 0 || registration.user_token_secret.length == 0){
            [self apiDidReturnError:@"初期設定に失敗しました" WithIdentifier:identifier];
            return;
        }
        
        //// Set UserDefaults
        userData.registered = YES;
        userData.user_id = registration.user_id;
        userData.user_token = registration.user_token;
        userData.user_token_secret = registration.user_token_secret;
        
        //// Delegate
        [self.delegate didRegisterUserAndSaved];
        return;
    }
    
    //// Fetching
    if(identifier == TwitterTimelineViewEnduerModelApiIdentifierFetchingUserData){
        return;
    }
}

- (void)dealloc
{
    self.delegate = nil;
}

@end
