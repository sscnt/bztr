//
//  UIViewModel.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSRequestParams.h"
#import "NSTrendApi.h"
#import "NSStatus.h"

@protocol TwitterTimelineViewStatusesModelDelegate <NSObject>
- (void)didLoadStatuses:(NSArray*)statuses;
- (void)didReturnError:(NSString*)error;
@end

@interface TwitterTimelineViewStatusesModel : NSObject <NSTrendApiDelegate>
{
    NSMutableDictionary* _statuses;
    NSTrendApi* _api;
}

@property (nonatomic, weak) id<TwitterTimelineViewStatusesModelDelegate> delegate;

- (void)loadStatusesWithApi:(NSString*)api params:(NSRequestParams*)params;
- (NSMutableArray*)statusesOnPage:(NSInteger)page;
- (void)cleanStatusesCache;

@end
