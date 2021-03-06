//
//  NSStatus.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSStatus.h"

@implementation NSStatus

- (id)initWithJsonObject:(NSDictionary *)json
{
    self = [super init];
    if(self){
        self.created_at = 0;
        if([json objectForKey:@"created_at_unixtime"] != nil){
            self.created_at = [[json objectForKey:@"created_at_unixtime"] integerValue];
        }
        self.favorite_count = 0;
        if([json objectForKey:@"favorite_count"] != nil){
            self.favorite_count = [[json objectForKey:@"favorite_count"] integerValue];
        }
        self.retweet_count = 0;
        if([json objectForKey:@"retweet_count"] != nil){
            self.retweet_count = [[json objectForKey:@"retweet_count"] integerValue];
        }
        self.id = 0;
        self.id_string = @"0";
        if([json objectForKey:@"id"] != nil){
            self.id = [[json objectForKey:@"id"] doubleValue];
            self.id_string = [NSString stringWithFormat:@"%@", [json objectForKey:@"id"]];
            
        }
        self.text = @"";
        if([json objectForKey:@"text"] != nil){
            self.text = [json objectForKey:@"text"];
        }
        self.type = @"word";
        self.photo = nil;
        if([json objectForKey:@"photo"] != nil){
            self.type = @"photo";
            self.photo = [[NSStatusPhoto alloc] initWithJsonObject:[json objectForKey:@"photo"]];

        }
        self.user = nil;
        if([json objectForKey:@"user"] != nil){
            self.user = [[NSStatusUser alloc] initWithJsonObject:[json objectForKey:@"user"]];
        }
    }
    return self;
}

@end
