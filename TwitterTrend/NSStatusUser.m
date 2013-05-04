//
//  NSStatusUser.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSStatusUser.h"

@implementation NSStatusUser

- (id)initWithJsonObject:(NSDictionary *)json
{
    self = [super init];
    if(self){
        self.id = 0;
        if([json objectForKey:@"id"] != nil){
            self.id = [[json objectForKey:@"id"] integerValue];
        }
        self.verified = NO;
        if([json objectForKey:@"verified"] != nil){
            self.verified = [[json objectForKey:@"verified"] boolValue];
        }
        self.description = @"";
        if([json objectForKey:@"description"] != nil){
            self.description = [json objectForKey:@"description"];
        }
        self.name = @"";
        if([json objectForKey:@"name"] != nil){
            self.name = [json objectForKey:@"name"];
        }
        self.screen_name = @"";
        if([json objectForKey:@"screen_name"] != nil){
            self.screen_name = [json objectForKey:@"screen_name"];
        }
        self.profile_image_url = @"";
        if([json objectForKey:@"profile_image_url"] != nil){
            self.profile_image_url = [json objectForKey:@"profile_image_url"];
        }
    }
    return self;
}

@end
