//
//  UIViewModel.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterTimelineViewModel.h"

@implementation TwitterTimelineViewModel

- (id)init
{
    self = [super init];
    if(self){
        _statusesArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)callApi:(NSString*)api params:(NSRequestParams*)params
{
    [NSTrendApi call:api params:params addTarget:self selector:@selector(didCallApi:)];
}

- (void)didCallApi:(NSDictionary *)json
{
    NSArray* errors = [json objectForKey:@"errors"];
    if(!errors || [errors count] > 0){
        
    } else {
        NSInteger page = [[json objectForKey:@"page"] integerValue];
        if(page < 0){
            page = 0;
        }
        if([_statusesArray objectAtIndex:page] == nil){
            dlog(@"\nNew Page");
            [_statusesArray insertObject:[[NSMutableArray alloc] init] atIndex:page];
        }
        for(int index = 0;index < [[json objectForKey:@"statuses"] count];index++){
            NSStatus* status = [[NSStatus alloc] initWithJsonObject:[[json objectForKey:@"statuses"] objectAtIndex:index]];
            [[_statusesArray objectAtIndex:page] insertObject:status atIndex:index];
        }
        json = nil;
    }
}

- (NSMutableArray*)statusesOnPage:(NSInteger)page
{
    return nil;
}

@end
