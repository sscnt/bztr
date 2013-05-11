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
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        _registered = [userDefaults boolForKey:@"registered"];
        if(_registered == YES){
            [self setData];
        } else {
            self.registered = NO;
            self.iCloudEnabled = NO;
        }
    }
    return self;
}

- (void)setData
{
    
}

- (BOOL)registered
{
    return _registered;
}

- (void)setRegistered:(BOOL)registered
{
    _registered = registered;
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:registered forKey:@"registered"];
    [userDefaults synchronize];
}


- (void)setICloudEnabled:(BOOL)iCloudEnabled
{
    _iCloudEnabled = iCloudEnabled;
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:iCloudEnabled forKey:@"iCloudEnabled"];
    [userDefaults synchronize];
}

@end
