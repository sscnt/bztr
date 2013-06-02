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
        userDefaultsKeyForiCloudEnabled = @"iCloud_enabled";
        userDefaultsKeyForRegistered = @"registered";
        userDefaultsKeyForUserId = @"user_id";
        userDefaultsKeyForUserToken = @"user_token";
        userDefaultsKeyForUserTokenSecret = @"user_token_secret";
        userDefaultsKeyForLastAnnouncementTime = @"last_announcement_time";
        
        //// Load Data
        LUKeychainAccess* userKeyChain = [LUKeychainAccess standardKeychainAccess];
        _registered = [userKeyChain boolForKey:userDefaultsKeyForRegistered];
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
    LUKeychainAccess* userKeyChain = [LUKeychainAccess standardKeychainAccess];
    _user_id = [userKeyChain integerForKey:userDefaultsKeyForUserId];
    _registered = [userKeyChain boolForKey:userDefaultsKeyForRegistered];
    _iCloudEnabled = [userKeyChain boolForKey:userDefaultsKeyForiCloudEnabled];
    _user_token = [userKeyChain stringForKey:userDefaultsKeyForUserToken];
    _user_token_secret = [userKeyChain stringForKey:userDefaultsKeyForUserTokenSecret];
    _last_announcement_time = [userKeyChain integerForKey:userDefaultsKeyForLastAnnouncementTime];
    _premium = NO;
}

- (NSInteger)user_id
{
    return _user_id;
}

- (void)setUser_id:(NSInteger)user_id
{
    LUKeychainAccess* userKeyChain = [LUKeychainAccess standardKeychainAccess];
    _user_id = user_id;
    [userKeyChain setInteger:user_id forKey:userDefaultsKeyForUserId];
}

- (NSInteger)last_announcement_time
{
    return _last_announcement_time;
}

- (void)setLast_announcement_time:(NSInteger)last_announce_time
{
    _last_announcement_time = last_announce_time;
    LUKeychainAccess* userKeyChain = [LUKeychainAccess standardKeychainAccess];
    [userKeyChain setInteger:_last_announcement_time forKey:userDefaultsKeyForLastAnnouncementTime];
}

- (BOOL)registered
{
    return _registered;
}

- (void)setRegistered:(BOOL)registered
{
    _registered = registered;
    LUKeychainAccess* userKeyChain = [LUKeychainAccess standardKeychainAccess];
    [userKeyChain setBool:registered forKey:userDefaultsKeyForRegistered];
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
    LUKeychainAccess* userKeyChain = [LUKeychainAccess standardKeychainAccess];
    [userKeyChain setBool:iCloudEnabled forKey:userDefaultsKeyForiCloudEnabled];
}

- (NSString*)user_token
{
    return _user_token;
}

- (void)setUser_token:(NSString *)user_token
{
    _user_token = user_token;
    LUKeychainAccess* userKeyChain = [LUKeychainAccess standardKeychainAccess];
    [userKeyChain setString:user_token forKey:userDefaultsKeyForUserToken];
}

- (NSString*)user_token_secret
{
    return _user_token_secret;
}

- (void)setUser_token_secret:(NSString *)user_token_secret
{
    _user_token_secret = user_token_secret;
    LUKeychainAccess* userKeyChain = [LUKeychainAccess standardKeychainAccess];
    [userKeyChain setString:user_token_secret forKey:userDefaultsKeyForUserTokenSecret];
}

@end
