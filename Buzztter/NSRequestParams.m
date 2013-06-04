//
//  NSRequestParams.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSRequestParams.h"

@implementation NSRequestParams

- (id)init
{
    self = [super init];
    if(self){
        self.max_fav = -1;
        self.max_rt = -1;
        self.min_fav = -1;
        self.min_rt = -1;
        self.page = -1;
        self.user_id_string = @"0";
        self.user_token = @"";
        self.user_token_secret = @"";
        self.receipt = @"";
        self.text = @"";
    }
    return self;
}

@end
