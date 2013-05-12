//
//  NSEnduserData.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/11.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSEnduserData : NSUserDefaults
{
    NSString* userDefaultsKeyForRegistered;
    NSString* userDefaultsKeyForiCloudEnabled;
    NSString* userDefaultsKeyForUserId;
    NSString* userDefaultsKeyForUserToken;
    NSString* userDefaultsKeyForUserTokenSecret;
    
    BOOL _registered;
    BOOL _iCloudEnabled;
    NSInteger _user_id;
    NSString* _user_token;
    NSString* _user_token_secret;
}

@property (nonatomic, assign) BOOL registered;
@property (nonatomic, assign) BOOL iCloudEnabled;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSString* user_token;
@property (nonatomic, assign) NSString* user_token_secret;

+ (NSEnduserData*)sharedEnduserData;
- (void)setData;

@end