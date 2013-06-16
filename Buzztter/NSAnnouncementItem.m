//
//  NSAnnouncementItem.m
//  Buzztter
//
//  Created by SSC on 2013/06/16.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSAnnouncementItem.h"

@implementation NSAnnouncementItem

- (id)initWithJson:(NSDictionary *)json
{
    self = [super init];
    if(self){
        self.created_at = [[json objectForKey:@"created_at"] intValue];
        self.text = [json objectForKey:@"text"];
    }
    return self;
}

@end
