//
//  NSEnduserData.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/11.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSEnduserData.h"

static NSEnduserData* _sharedEnduserData = nil;

@implementation NSEnduserData

+ (NSEnduserData*)sharedEnduserData
{
    @synchronized(self) {
        if (_sharedEnduserData == nil) {
            (void) [[self alloc] init];
        }
    }
    return _sharedEnduserData;
}


+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (_sharedEnduserData == nil) {
            _sharedEnduserData = [super allocWithZone:zone];
            return _sharedEnduserData;
        }
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if(self){
        //// Set Keys
        userDefaultsKeyForiCloudEnabled = @"iCloudEnabled";
        userDefaultsKeyForRegistered = @"registered";
        userDefaultsKeyForUserId = @"user_id";
        userDefaultsKeyForUserToken = @"user_token";
        userDefaultsKeyForUserTokenSecret = @"user_token_secret";
        userDefaultsKeyForLastAnnouncementTime = @"LastAnnouncementTime";
        
        //// Load Data
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        _registered = [userDefaults boolForKey:userDefaultsKeyForRegistered];
        if(_registered == YES){
            [self setData];
        } else {
            self.registered = NO;
            self.iCloudEnabled = NO;
            self.last_announcement_time = 0;
        }
    }
    return self;
}

- (void)setData
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    _user_id = [userDefaults integerForKey:userDefaultsKeyForUserId];
    _registered = [userDefaults boolForKey:userDefaultsKeyForRegistered];
    _iCloudEnabled = [userDefaults boolForKey:userDefaultsKeyForiCloudEnabled];
    _user_token = [userDefaults stringForKey:userDefaultsKeyForUserToken];
    _user_token_secret = [userDefaults stringForKey:userDefaultsKeyForUserTokenSecret];
    _last_announcement_time = [userDefaults integerForKey:userDefaultsKeyForLastAnnouncementTime];
    _premium = NO;
}

- (NSInteger)user_id
{
    return _user_id;
}

- (void)setUser_id:(NSInteger)user_id
{
    _user_id = user_id;
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:user_id forKey:userDefaultsKeyForUserId];
    [userDefaults synchronize];
}

- (NSInteger)last_announcement_time
{
    return _last_announcement_time;
}

- (void)setLast_announcement_time:(NSInteger)last_announce_time
{
    _last_announcement_time = last_announce_time;
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:_last_announcement_time forKey:userDefaultsKeyForLastAnnouncementTime];
    [userDefaults synchronize];
}

- (BOOL)registered
{
    return _registered;
}

- (void)setRegistered:(BOOL)registered
{
    _registered = registered;
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:registered forKey:userDefaultsKeyForRegistered];
    [userDefaults synchronize];
}

- (BOOL)premium
{
    return _premium;
}

- (void)setPremium:(BOOL)premium
{
    _premium = premium;
}

- (BOOL)iCloudEnabled
{
    return _iCloudEnabled;
}

- (void)setICloudEnabled:(BOOL)iCloudEnabled
{
    _iCloudEnabled = iCloudEnabled;
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:iCloudEnabled forKey:userDefaultsKeyForiCloudEnabled];
    [userDefaults synchronize];
}

- (NSString*)user_token
{
    return _user_token;
}

- (void)setUser_token:(NSString *)user_token
{
    _user_token = user_token;
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:user_token forKey:userDefaultsKeyForUserToken];
    [userDefaults synchronize];
}

- (NSString*)user_token_secret
{
    return _user_token_secret;
}

- (void)setUser_token_secret:(NSString *)user_token_secret
{
    _user_token_secret = user_token_secret;
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:user_token_secret forKey:userDefaultsKeyForUserTokenSecret];
    [userDefaults synchronize];
}

@end
