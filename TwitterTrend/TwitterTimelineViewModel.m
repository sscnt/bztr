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
        _statuses = [NSMutableDictionary dictionary];
        _api = [[NSTrendApi alloc] init];
        _api.delegate = self;
    }
    return self;
}

- (void)callApi:(NSString*)api params:(NSRequestParams*)params
{
    [_api call:api params:params];
}

- (NSMutableArray*)statusesOnPage:(NSInteger)page
{
    return nil;
}


//// NSTrendApiDelegate

- (void)apiDidReturnError:(NSString*)error
{
    
}

- (void)apiDidReturnResult:(NSDictionary*)json
{
    NSInteger page = [[json objectForKey:@"page"] integerValue];
    if(page < 0){
        page = 0;
    }
    if([_statuses objectForKey:[NSString stringWithFormat:@"%d", page]] == nil){
        dlog(@"New Page");
        [_statuses setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%d", page]];
    }
    for(int index = 0;index < [[json objectForKey:@"statuses"] count];index++){
        NSStatus* status = [[NSStatus alloc] initWithJsonObject:[[json objectForKey:@"statuses"] objectAtIndex:index]];
        [[_statuses objectForKey:[NSString stringWithFormat:@"%d", page]] insertObject:status atIndex:index];
    }
    [self.delegate didLoadStatuses:[_statuses objectForKey:[NSString stringWithFormat:@"%d", page]]];
}


@end
