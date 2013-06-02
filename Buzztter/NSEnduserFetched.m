//
//  NSEnduserFetched.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/12.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSEnduserFetched.h"

@implementation NSEnduserFetched
- (id)initWithJsonObject:(NSDictionary *)json
{
    
    self = [super init];
    if(self){
        self.premium = 0;
        if([json objectForKey:@"premium"] != nil){
            self.premium = [[json objectForKey:@"premium"] integerValue];
        }
        
        self.announcement = @"";
        if([json objectForKey:@"announcement"] != nil){
            self.announcement = [json objectForKey:@"announcement"];
        }
        
        self.announcement_time = 0;
        if([json objectForKey:@"announcement_time"] != nil){
            self.announcement_time = [[json objectForKey:@"announcement_time"] integerValue];
        }
        
        self.premium_limit_time = 0;
        if([json objectForKey:@"premium_limit_time"] != nil){
            self.premium_limit_time = [[json objectForKey:@"premium_limit_time"] integerValue];
        }       

    }
    return self;
}

@end
