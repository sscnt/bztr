//
//  UIViewModel.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "TwitterTimelineViewStatusesModel.h"

@implementation TwitterTimelineViewStatusesModel

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

- (void)loadStatusesWithApi:(NSString*)api params:(NSRequestParams*)params
{
    if([_statuses objectForKey:[NSString stringWithFormat:@"%d", params.page]] == nil){
        dlog(@"Cache not found.");
        [_api call:api params:params];
    }else{
        dlog(@"Loaded form cache.");
        dlog(@"Page:%d", params.page);
        [self.delegate didLoadStatuses:[self statusesOnPage:params.page]];
    }
}

- (void)developerBlockWithParams:(NSRequestParams *)params
{
    
}

- (NSMutableArray*)statusesOnPage:(NSInteger)page
{
    return [_statuses objectForKey:[NSString stringWithFormat:@"%d", page]];
}

- (void)cleanStatusesCache
{
    for(NSString* key in _statuses){
        NSMutableArray* array = [_statuses objectForKey:key];
        [array removeAllObjects];
    }
    [_statuses removeAllObjects];
}

//// NSTrendApiDelegate

- (void)apiDidReturnError:(NSString*)error
{
    [self.delegate didReturnError:error];
}

- (void)apiDidReturnResult:(NSDictionary*)json
{
    NSInteger page = [[json objectForKey:@"page"] integerValue];
    if(page < 0){
        page = 0;
    }
    dlog(@"Page:%d", page);
    if([_statuses objectForKey:[NSString stringWithFormat:@"%d", page]] == nil){
        [_statuses setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%d", page]];
    }
    for(int index = 0;index < [[json objectForKey:@"statuses"] count];index++){
        NSStatus* status = [[NSStatus alloc] initWithJsonObject:[[json objectForKey:@"statuses"] objectAtIndex:index]];
        [[_statuses objectForKey:[NSString stringWithFormat:@"%d", page]] insertObject:status atIndex:index];
    }
    [self.delegate didLoadStatuses:[_statuses objectForKey:[NSString stringWithFormat:@"%d", page]]];
}


@end
