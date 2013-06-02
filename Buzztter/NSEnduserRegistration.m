//
//  NSEnduserRegistration.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSEnduserRegistration.h"

@implementation NSEnduserRegistration

- (id)initWithJsonObject:(NSDictionary *)json
{
    
    self = [super init];
    if(self){
        self.user_id = 0;
        if([json objectForKey:@"user_id"] != nil){
            self.user_id = [[json objectForKey:@"user_id"] integerValue];
        }
        
        self.user_token = @"";
        if([json objectForKey:@"user_token"] != nil){
            self.user_token = [json objectForKey:@"user_token"];
        }
        
        self.user_token_secret = @"";
        if([json objectForKey:@"user_token_secret"] != nil){
            self.user_token_secret = [json objectForKey:@"user_token_secret"];
        }
    }
    return self;
}

@end
