//
//  NSEnduserRegistration.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSEnduserRegistration : NSObject

@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, strong) NSString* user_token;
@property (nonatomic, strong) NSString* user_token_secret;


- (id)initWithJsonObject:(NSDictionary*)json;


@end
