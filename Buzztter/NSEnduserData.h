//
//  NSEnduserData.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/11.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LUKeychainAccess.h"


@interface NSEnduserData : NSObject
{
    NSString* userDefaultsKeyForRegistered;
    NSString* userDefaultsKeyForiCloudEnabled;
    NSString* userDefaultsKeyForUserId;
    NSString* userDefaultsKeyForLastAnnouncementTime;
    NSString* userDefaultsKeyForUserToken;
    NSString* userDefaultsKeyForUserTokenSecret;
    
    BOOL _registered;
    BOOL _iCloudEnabled;
    BOOL _premium;
    NSInteger _user_id;
    NSInteger _last_announcement_time;
    NSString* _user_token;
    NSString* _user_token_secret;
}

@property (nonatomic, assign) BOOL registered;
@property (nonatomic, assign) BOOL premium;
@property (nonatomic, assign) BOOL iCloudEnabled;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger last_announcement_time;
@property (nonatomic, strong) NSString* user_token;
@property (nonatomic, strong) NSString* user_token_secret;

+ (NSEnduserData*)sharedEnduserData;
- (void)setData;

@end
