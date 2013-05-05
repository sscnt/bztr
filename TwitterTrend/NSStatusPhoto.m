//
//  NSStatusPhoto.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSStatusPhoto.h"

@implementation NSStatusPhoto

- (id)initWithJsonObject:(NSDictionary *)json
{
    self = [super init];
    if(self){
        self.media_url = @"";
        if([json objectForKey:@"media_url"] != nil){
            self.media_url = [json objectForKey:@"media_url"];
        }
        self.width = 0;
        self.height = 0;
        if([json objectForKey:@"sizes"] != nil){
            if([[json objectForKey:@"sizes"] objectForKey:@"medium"] != nil){
                self.width = [[[[json objectForKey:@"sizes"] objectForKey:@"medium"] objectForKey:@"w"] integerValue];
                self.height = [[[[json objectForKey:@"sizes"] objectForKey:@"medium"] objectForKey:@"h"] integerValue];
            }
        }

    }
    return self;
}

@end
