//
//  NSTrendApi.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "NSTrendApi.h"

@implementation NSTrendApi

- (void)call:(NSString *)api params:(NSRequestParams *)params
{
    
}

- (void)didCall:(NSDictionary *)json
{
    NSArray* errors = [json objectForKey:@"errors"];
    if(!errors || [errors count] > 0){
        
    } else {

    }
}

@end
