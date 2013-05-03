//
//  NSStatus.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSStatusUser.h"
#import "NSStatusPhoto.h"

@interface NSStatus : NSDictionary

- (id)initWithJsonObject:(NSDictionary*)json;

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger created_at;
@property (nonatomic, assign) NSInteger favorite_count;
@property (nonatomic, assign) NSInteger retweet_count;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSStatusPhoto* photo;
@property (nonatomic, strong) NSStatusUser* user;


@end
