//
//  NSEnduserFetched.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSEnduserFetched : NSObject

@property (nonatomic, assign) NSInteger announcement_time;
@property (nonatomic, strong) NSString* announcement;
@property (nonatomic, assign) NSInteger premium;
@property (nonatomic, assign) NSInteger premium_limit_time;

- (id)initWithJsonObject:(NSDictionary*)json;

@end
